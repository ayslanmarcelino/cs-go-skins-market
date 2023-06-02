module Steam
  class AccountsController < ApplicationController
    load_and_authorize_resource

    before_action :steam_account, only: :update

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
          flash[:danger] = 'Conta não existe. Favor preencher com a URL personalizada do seu perfil.' if @updated_steam_account.nil?
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
  end
end
