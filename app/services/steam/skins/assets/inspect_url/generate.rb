module Steam
  module Skins
    module Assets
      module InspectUrl
        class Generate < ApplicationService
          def initialize(steam_account:, skin:, asset_id:)
            @steam_account = steam_account
            @skin = skin
            @asset_id = asset_id
          end

          def call
            generate
          end

          private

          def generate
            "#{base_url}#{dynamic_skin}#{inspect_url_code}"
          end

          def inspect_url_code
            return if inspect_url.blank?

            inspect_url.match(/%D(\d+)/)[1]
          end

          def inspect_url
            @skin['actions']&.first&.fetch('link', nil)
          end

          def dynamic_skin
            "#{@steam_account.steam_id}A#{@asset_id}D"
          end

          def base_url
            @url ||= 'steam://rungame/730/76561202255233023/+csgo_econ_action_preview%20S'
          end
        end
      end
    end
  end
end

# steam://rungame/730/76561202255233023/+csgo_econ_action_preview%20S76561198345749032A30665714007D10272229733627967232
