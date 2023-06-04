module Steam
  module Skins
    module Assets
      module Price
        class Find < ApplicationService
          def initialize(skin_name:)
            @skin_name = skin_name
          end

          def call
            find
          end

          private

          def find
            price.nil? ? 0 : price.gsub(/[^\d,]/, '').sub(',', '.').to_f
          end

          def price
            @price ||= parsed_response['lowest_price']
          end

          def parsed_response
            @parsed_response ||= JSON.parse(response.body)
          end

          def response
            sleep(3)

            @response ||= RestClient.get(endpoint)
          end

          def endpoint
            "https://steamcommunity.com/market/priceoverview/?currency=7&appid=730&market_hash_name=#{escaped_name}"
          end

          def escaped_name
            CGI.escape(@skin_name)
          end
        end
      end
    end
  end
end
