module Steam
  module Skins
    class Create < ApplicationService
      def initialize(steam_id:)
        @steam_id = steam_id
      end

      def call
        create!
      end

      private

      def create!
        # Skins::Create.call(request: @request, skins: @skins, inventory: @inventory)
      end

      def inventory
        @inventory ||= JSON.parse(@params)['assets']
      end

      def skins
        @skins ||= JSON.parse(@params)['descriptions'].reverse
      end

      def request
        @request ||= Steam::Request.call(steam_id: steam_id)
      end
    end
  end
end
