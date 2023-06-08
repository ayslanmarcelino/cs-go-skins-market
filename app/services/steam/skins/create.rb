module Steam
  module Skins
    class Create < ApplicationService
      DEFAULT_BETWEEN_TIME = 120

      def initialize(current_user:, steam_account:)
        @current_user = current_user
        @steam_account = steam_account
      end

      def call
        ActiveRecord::Base.transaction do
          create_consult!
          update_consult!
          create!
        end
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

        update_last_search!
      end

      def create_consult!
        return if skin_consult

        @skin_consult ||= Skin::Consult.create(
          raw_data: parsed_json,
          steam_id_decimal: @steam_account.steam_id
        )

        update_last_search!
      end

      def update_last_search!
        @current_user.update(last_search: Time.current)
      end

      def permitted_update?
        !@current_user.last_search.between?(interval_in_minute.presence || DEFAULT_BETWEEN_TIME.minutes.ago, Time.current)
      end

      def interval_in_minute
        @interval_in_minute ||= @current_user.interval_in_minute.nil? ? nil : @current_user.interval_in_minute.minutes.ago
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
