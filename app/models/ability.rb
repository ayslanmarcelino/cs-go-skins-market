class Ability
  include CanCan::Ability
  attr_reader :user

  def initialize(user)
    return unless user

    @user = user
    @user.roles.includes(:enterprise).find_each do |role|
      next unless user.current_enterprise == role.enterprise

      PerEnterpriseAbility.new(self, enterprise: @user.current_enterprise, user: @user).permit(role.kind)
    end

    can([:update, :update_current_enterprise], User, id: @user.id)
  end

  class PerEnterpriseAbility
    def initialize(ability, enterprise:, user:)
      @ability = ability
      @enterprise = enterprise
      @user = user
    end

    def permit(kind)
      case kind
      when :admin_master
        can(:manage, :all)
      when :owner
        owner_abilities
      when :viewer
        viewer_abilities
      end
    end

    private

    def can(*args)
      @ability.can(*args)
    end

    def cannot(*args)
      @ability.cannot(*args)
    end

    def owner_abilities
      can(
        [:read, :update, :disable, :activate],
        User,
        roles: {
          enterprise_id: @enterprise.id, kind_cd: User::Role::USER_KINDS.map(&:to_s)
        }
      )
      can(:create, User)
      can([:read, :update, :destroy], User::Role, enterprise: @enterprise, kind_cd: User::Role::USER_KINDS.map(&:to_s))
      can(:create, User::Role, enterprise: @enterprise)
      can([:read, :create, :destroy, :disable], Steam::Account, enterprise: @enterprise, owner: @user)
      can([:update, :enable], Steam::Account, enterprise: @enterprise, owner: @user, available: true)
      can([:read, :search], Skin, steam_account: @user.accounts, steam_account: { enterprise: @enterprise })
      can(:enable, Skin, steam_account: @user.accounts, available: false)
      can([:update, :disable], Skin, steam_account: @user.accounts, available: true)
      can(:create, Transaction::Type)
      can(:read, Transaction, owner: @user)
      can(:create, Transaction)
      can([:update, :cancel, :finish], Transaction, owner: @user, aasm_state: 'pending')
    end

    def viewer_abilities
      can(:read, User, roles: { enterprise_id: @enterprise.id, kind_cd: User::Role::USER_KINDS.map(&:to_s) })
      can(:read, User::Role, enterprise: @enterprise, kind_cd: User::Role::USER_KINDS.map(&:to_s))
    end
  end
end
