class SkinsController < ApplicationController
  before_action :steam_account, only: :search

  def index
    @skins = Skin.all
  end

  def search
    @skins ||= Steam::Skins::Create.call(steam_id: steam_account.steam_id)
  end

  private

  def steam_account
    @steam_account ||= Steam::Account.find(params.require(:steam_account_id))
  end
end
