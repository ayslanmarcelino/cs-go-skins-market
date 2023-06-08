module Steam
  module Skins
    class Create < ApplicationService
      DEFAULT_BETWEEN_TIME = 1.hour.ago.freeze

      def initialize(steam_account:)
        @steam_account = steam_account
      end

      def call
        create_consult!
        update_consult!
        create!
      end

      private

      def create!
        ::Skins::Create.call(steam_account: @steam_account, skins: skins, inventory: inventory)
      end

      def inventory
        @inventory ||= @skin_consult.raw_data['assets']
      end

      def skins
        @skins ||= @skin_consult.raw_data['descriptions'].reverse
      end

      def update_consult!
        return unless permitted_update?

        skin_consult.update(
          raw_data: parsed_json,
          updated_at: Time.current
        )
      end

      def create_consult!
        return if skin_consult

        @skin_consult ||= Skin::Consult.create(
          raw_data: parsed_json,
          steam_id_decimal: @steam_account.steam_id
        )
      end

      def permitted_update?
        !skin_consult.updated_at.between?(DEFAULT_BETWEEN_TIME, Time.current)
      end

      def skin_consult
        @skin_consult ||= Skin::Consult.find_by(steam_id_decimal: @steam_account.steam_id)
      end

      def parsed_json
        @parsed_json ||= JSON.parse(request)
      end

      def request
        @request ||= Steam::Request.call(steam_id: @steam_account.steam_id)
      end
    end
  end
end
