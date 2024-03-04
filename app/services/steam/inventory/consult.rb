# frozen_string_literal: true

module Steam
  module Inventory
    class Consult < ApplicationService
      def initialize(steam_id:)
        @steam_id = steam_id
      end

      def call
        request
      end

      private

      def request
        response.body
      end

      def response
        @response ||= RestClient.get(endpoint)
      end

      def endpoint
        @endpoint ||= "https://steamcommunity.com/inventory/#{@steam_id}/730/2?l=brazilian"
      end
    end
  end
end
