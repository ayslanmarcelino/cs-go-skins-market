class Inventories::Skins::CreateJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3
  sidekiq_retry_in { 360 }

  def perform(current_user:, steam_account:)
    Inventories::Skins::Create.call(current_user: current_user, steam_account: steam_account)
  end
end
