class Inventories::Skins::CreateJob < ApplicationJob
  queue_as :default

  def perform(current_user:, steam_account:)
    Inventories::Skins::Create.call(current_user: current_user, steam_account: steam_account)
  end
end
