module Inventories
  module Skins
    module Data
      class SteamWebApi < Base
        def name
          skin['marketname']
        end

        def market_name
          skin['markethashname']
        end

        def name_color
          skin['bordercolor']
        end

        def kind
          skin['tags']&.first&.dig('localized_tag_name')
        end

        def gun_kind
          skin['tags']&.second&.dig('localized_tag_name')
        end

        def asset_id
          skin['assetid']
        end

        def marketable
          skin['marketable']
        end

        def type
          skin['type']
        end

        def image
          skin['image']
        end

        def inspect_url
          skin['inspectlink']
        end

        def exterior
          Steam::Skins::Assets::Exterior::Find.call(skin: skin)
        end

        def name_tag
          skin['nametag']
        end

        def steam_price
          skin['pricelatest']
        end

        def stattrak
          skin['isstattrak']
        end

        def sticker_name
          Steam::Skins::Assets::Stickers::Names::Find.call(skin: skin)
        end

        def sticker_image
          Steam::Skins::Assets::Stickers::Images::Find.call(skin: skin)
        end

        def expiration_date
          Steam::Skins::Assets::ExpirationDate::Find.call(class_id: skin['classid'])
        end
      end
    end
  end
end
