# frozen_string_literal: true

module SteamWebApi
  module Inventories
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
        @response ||= RestClient.get(
          endpoint,
          { 'X-RapidAPI-Key' => ENV['STEAM_WEB_API_KEY'] }
        )
      end

      def endpoint
        @endpoint ||= "https://#{ENV['STEAM_WEB_API_HOST']}/steam/api/inventory?steam_id=#{@steam_id}&parse=1&group=1&game=csgo&language=brazilian&currency=brl"
      end
    end
  end
end
