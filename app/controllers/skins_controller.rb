class SkinsController < ApplicationController
  load_and_authorize_resource

  before_action :steam_account, only: :search

  def index
    @query = Skin.includes(:steam_account)
                 .order(created_at: :desc)
                 .accessible_by(current_ability)
                 .page(params[:page])
                 .ransack(params[:q])

    @skins = @query.result(distinct: false)
  end

  def search
    @search ||= Steam::Skins::Create.call(steam_account: steam_account)
  end

  private

  def steam_account
    @steam_account ||= Steam::Account.find(params.require(:steam_account_id))
  end
end
