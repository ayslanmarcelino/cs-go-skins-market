module Steam
  module AssetClass
    module Information
      class Find < ApplicationService
        def initialize(class_id:)
          @class_id = class_id
        end

        def call
          find
        end

        private

        def find
          JSON.parse(response.body)['result'].first.second
        end

        def response
          @response ||= RestClient.get(endpoint)
        end

        def endpoint
          @endpoint ||= "https://api.steampowered.com/ISteamEconomy/GetAssetClassInfo/v1/?key=#{ENV['STEAM_API_KEY']}&class_count=1&classid0=#{@class_id}&appid=730"
        end
      end
    end
  end
end
