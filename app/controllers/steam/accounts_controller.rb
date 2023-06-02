module Steam
  class AccountsController < ApplicationController
    load_and_authorize_resource

    before_action :steam_account, only: [:update, :disable, :enable]

    def index
      @query = Steam::Account.accessible_by(current_ability).page(params[:page]).ransack(params[:q])

      @steam_accounts = @query.result(distinct: false)
    end

    def new
      @steam_account = Steam::Account.new
    end

    def create
      @steam_account = Steam::Account.new(account_params)

      if @steam_account.valid?
        ActiveRecord::Base.transaction do
          update_steam_account!

          @steam_account.save if @updated_steam_account
          if @updated_steam_account.nil?
            flash[:danger] = 'Conta não existe. Favor preencher com a URL personalizada do seu perfil.'
          end
        end

        redirect_to(steam_accounts_path)
        flash[:success] = 'Conta Steam criada com sucesso.'
      else
        render(:new, status: :unprocessable_entity)
      end
    end

    def update
      update_steam_account!(persisted: true)

      redirect_to(steam_accounts_path)
      flash[:success] = 'Conta Steam atualizada com sucesso.'
    end

    def disable
      if @steam_account.active?
        disable!(@steam_account)
        redirect_success(path: steam_accounts_path, action: 'desativada')
      else
        redirect_failed(path: steam_accounts_path, action: 'desativada')
      end
    end

    def enable
      if disabled?(@steam_account)
        activate!(@steam_account)
        redirect_success(path: steam_accounts_path, action: 'ativada')
      else
        redirect_failed(path: steam_accounts_path, action: 'ativada')
      end
    end

    private

    def account_params
      params.require(:steam_account)
            .permit(Steam::Account.permitted_params)
            .merge(owner: current_user, enterprise: current_user.current_enterprise)
    end

    def steam_account
      @steam_account ||= Steam::Account.find(params[:id])
    end

    def update_steam_account!(persisted: nil)
      @updated_steam_account = Steam::Accounts::Players::Update.call(steam_account: @steam_account, persisted: persisted)
    end

    def redirect_success(path:, action:)
      redirect_to(path)
      flash[:success] = "Conta da Steam #{action} com sucesso."
    end
  end
end
