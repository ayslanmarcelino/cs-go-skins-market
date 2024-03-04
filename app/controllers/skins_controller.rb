class SkinsController < ApplicationController
  load_and_authorize_resource

  before_action :steam_account, only: :search
  before_action :skin, only: [:show, :edit, :disable, :enable]
  before_action :steam_accounts, only: :index

  def index
    @query = Skin.includes(:steam_account)
                 .order(created_at: :desc)
                 .accessible_by(current_ability)
                 .page(params[:page])
                 .ransack(params[:q])

    @skins = @query.result(distinct: false)
  end

  def show; end

  def edit; end

  def update
    if @skin.update(skin_params) && @skin.available?
      redirect_success(path: skins_path, action: 'atualizada')
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def search
    Steam::Skins::CreateJob.perform_later(current_user: current_user, steam_account: steam_account)

    flash[:success] = 'A busca das skins desta conta será realizada em breve. Quando finalizado, iremos notificá-lo.'
    redirect_to(skins_path)
  end

  def update_prices
    ActiveRecord::Base.transaction do
      Steam::Skins::Assets::Price::Update.call(current_user: current_user, steam_account: steam_account)
    end
  end

  def disable
    if @skin.available?
      make_unavailable!(@skin)
      redirect_success(path: skins_path, action: 'marcada como indisponível')
    else
      redirect_failed(path: skins_path, action: 'marcada como indisponível')
    end
  end

  def enable
    if unavailable?(@skin)
      make_available!(@skin)
      redirect_success(path: skins_path, action: 'marcada como disponível')
    else
      redirect_failed(path: skins_path, action: 'marcada como disponível')
    end
  end

  def available
    @skins = Skin.accessible_by(current_ability).available.order(created_at: :desc)
  end

  private

  def skin_params
    params.require(:skin)
          .permit(Skin.permitted_params)
  end

  def steam_account
    @steam_account ||= Steam::Account.find(params.require(:steam_account_id))
  end

  def skin
    @skin ||= Skin.find(params.require(:id))
  end

  def steam_accounts
    @steam_accounts ||= Steam::Account.where(owner: current_user, enterprise: current_user.current_enterprise, active: true)
  end

  def redirect_success(path:, action:)
    redirect_to(path)
    flash[:success] = "Skin #{action} com sucesso."
  end
end
