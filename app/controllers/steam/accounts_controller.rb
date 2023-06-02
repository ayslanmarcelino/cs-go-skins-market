module Steam
  class AccountsController < ApplicationController
    load_and_authorize_resource

    def index
      @query = Steam::Account.accessible_by(current_ability).page(params[:page]).ransack(params[:q])

      @steam_accounts = @query.result(distinct: false)
    end

    def new
      @steam_account = Steam::Account.new
    end

    def create
      @steam_account = Steam::Account.new(account_params)

      if @steam_account.save
        Steam::Accounts::Players::Update.call(steam_account: @steam_account) if @steam_account.persisted?

        redirect_success(path: steam_accounts_path, action: 'criada')
      else
        render(:new, status: :unprocessable_entity)
      end
    end

    private

    def account_params
      params.require(:steam_account)
            .permit(Steam::Account.permitted_params)
            .merge(user: current_user, enterprise: current_user.current_enterprise)
    end

    def redirect_success(path:, action:)
      redirect_to(path)
      flash[:success] = "Conta Steam #{action} com sucesso."
    end
  end
end
