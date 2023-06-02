module Steam
  module Accounts
    module Players
      class Find < ApplicationService
        def initialize(steam_custom_id:, persisted: false)
          @steam_custom_id = steam_custom_id
          @persisted = persisted
        end

        def call
          find
        end

        private

        def find
          JSON.parse(response.body)['response']['players'].first
        end

        def response
          @response ||= RestClient.get(endpoint)
        end

        def steam_id
          @steam_id ||= @persisted ? @steam_custom_id : Steam::Accounts::SteamIds::Find.call(steam_custom_id: @steam_custom_id)
        end

        def endpoint
          @endpoint ||= "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{ENV['STEAM_API_KEY']}&steamids=#{steam_id}"
        end
      end
    end
  end
end
