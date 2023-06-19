module Skins
  module Prices
    class Update < ApplicationService
      def initialize(steam_account:, skins:, inventory:)
        @steam_account = steam_account
        @skins = skins
        @inventory = inventory
      end

      def call
        update!
      end

      private

      def update!
        @skins.each do |skin|
          asset_id = asset_id(skin: skin)

          next if skin['marketable'].zero? || Skin::REJECT_TYPES.include?(skin['type'])

          persisted_skin = find_skin(asset_id: asset_id)

          next unless persisted_skin

          new_steam_price = steam_price(skin_name: skin['market_hash_name'])

          next if new_steam_price == persisted_skin.steam_price

          ActiveRecord::Base.transaction do
            persisted_skin.update(steam_price: new_steam_price)
            create_log!(new_skin: persisted_skin)
          end
        end
      end

      def create_log!(new_skin:)
        Skins::Logs::Create.call(steam_price: new_skin.steam_price, skin: new_skin)
      end

      def steam_price(skin_name:)
        Steam::Skins::Assets::Price::Find.call(skin_name: skin_name)
      end

      def find_skin(asset_id:)
        Skins::Find.call(steam_account: @steam_account, steam_id: asset_id, available: true)
      end

      def asset_id(skin:)
        Steam::Skins::Assets::Find.call(inventory: @inventory, skin: skin)
      end
    end
  end
end
