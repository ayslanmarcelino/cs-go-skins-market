module Steam
  module Skins
    class Create < ApplicationService
      def initialize(steam_account:)
        @steam_account = steam_account
      end

      def call
        create!
      end

      private

      def create!
        ::Skins::Create.call(steam_account: @steam_account, skins: skins, inventory: inventory)
      end

      def inventory
        @inventory ||= parsed_json['assets']
      end

      def skins
        @skins ||= parsed_json['descriptions'].reverse
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
