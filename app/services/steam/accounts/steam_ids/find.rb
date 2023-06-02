module Steam
  module Accounts
    module SteamIds
      class Find < ApplicationService
        def initialize(steam_custom_id:)
          @steam_custom_id = steam_custom_id
        end

        def call
          find
        end

        private

        def find
          JSON.parse(response.body)['response']['steamid']
        end

        def response
          @response ||= RestClient.get(endpoint)
        end

        def endpoint
          @endpoint ||= "https://api.steampowered.com/ISteamUser/ResolveVanityURL/v0001/?key=#{ENV['STEAM_API_KEY']}&vanityurl=#{@steam_custom_id}"
        end
      end
    end
  end
end
