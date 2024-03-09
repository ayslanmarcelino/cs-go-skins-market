class Inventories::Skins::CreateJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3
  sidekiq_retry_in { 900 }

  def perform(current_user:, steam_account:)
    Inventories::Skins::Create.call(current_user: current_user, steam_account: steam_account)

    # TODO: Criar uma listagem de chamadas com status
  rescue StandardError => e
    # TODO: Criar um alerta para o usuário informando que deu erro

    Rails.logger.debug("#{steam_account.provider_cd.capitalize}: #{e}")
  end
end
