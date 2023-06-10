module Steam
  module Skins
    module Assets
      module Price
        class Find < ApplicationService
          DEFAULT_BETWEEN_TIME = 60

          def initialize(skin_name:)
            @skin_name = skin_name
          end

          def call
            ActiveRecord::Base.transaction do
              create_consult!
              update_consult!
              find
            end
          end

          private

          def find
            price.nil? ? 0 : price.gsub(/[^\d,]/, '').sub(',', '.').to_f
          end

          def price
            @price ||= skin_consult.raw_data['lowest_price']
          end

          def update_consult!
            return unless permitted_update?

            skin_consult.update(
              raw_data: parsed_response,
              updated_at: Time.current
            )
          end

          def permitted_update?
            !@skin_consult.updated_at.between?(DEFAULT_BETWEEN_TIME.minutes.ago, Time.current)
          end

          def create_consult!
            return if skin_consult

            @skin_consult ||= Skin::Consult.create(
              raw_data: parsed_response,
              endpoint: endpoint,
              source: :skin_price
            )
          end

          def skin_consult
            @skin_consult ||= Skin::Consult.find_by(source_cd: :skin_price, endpoint: endpoint)
          end

          def parsed_response
            @parsed_response ||= JSON.parse(response.body)
          end

          def response
            sleep(5)

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
