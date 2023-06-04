module Steam
  module Skins
    module Assets
      module Images
        class Find < ApplicationService
          def initialize(skin:)
            @skin = skin
          end

          def call
            find
          end

          private

          def find
            "https://steamcommunity-a.akamaihd.net/economy/image/#{image}"
          end

          def image
            @skin['icon_url_large'].presence || @skin['icon_url']
          end
        end
      end
    end
  end
end
