module Inventories
  module Skins
    class Create < ApplicationService
      DEFAULT_BETWEEN_TIME = 120

      def initialize(current_user:, steam_account:)
        @current_user = current_user
        @steam_account = steam_account
      end

      def call
        return unless permitted_update?

        ActiveRecord::Base.transaction do
          create_consult!
          update_consult!
          create_skins!
        end
      end

      private

      def create_skins!
        constantized_provider::Skins::Create.call(steam_account: @steam_account, consult: consult)
      end

      def update_consult!
        return unless consult

        consult.update(raw_data: parsed_json)

        update_last_search!
      end

      def create_consult!
        return if consult

        @consult ||= Skin::Consult.create(
          raw_data: parsed_json,
          steam_id_decimal: @steam_account.steam_id,
          source: :inventory
        )

        update_last_search!
      end

      def update_last_search!
        @current_user.update(last_search: Time.current)
      end

      def interval_in_minute
        @interval_in_minute ||= @current_user.interval_in_minute&.minutes&.ago
      end

      def consult
        @consult ||= Skin::Consult.find_by(steam_id_decimal: @steam_account.steam_id, source_cd: :inventory)
      end

      def parsed_json
        @parsed_json ||= JSON.parse(request)
      end

      def request
        @request ||= constantized_provider::Inventories::Consult.call(steam_id: @steam_account.steam_id)
      end

      def constantized_provider
        @steam_account.provider_cd.camelize.constantize
      end

      def permitted_update?
        !@current_user.last_search&.between?(interval_in_minute.presence || DEFAULT_BETWEEN_TIME.minutes.ago, Time.current)
      end
    end
  end
end
