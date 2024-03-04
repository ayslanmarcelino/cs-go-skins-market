module Steam
  module Skins
    class Create < ApplicationService
      def initialize(steam_account:, consult:)
        @steam_account = steam_account
        @consult = consult
      end

      def call
        create!
      end

      private

      def inventory
        @inventory ||= @consult.raw_data['assets']
      end

      def skins
        @skins ||= @consult.raw_data['descriptions'].reverse
      end

      def create!
        @skins.each do |skin|
          asset_id = asset_id(skin: skin)

          next if skin['marketable'].zero? || ignore_skin_type?(skin: skin)
          next if persisted_skin_available?(asset_id: asset_id)

          new_skin = Skin.new
          fill_basic_data(skin: skin, new_skin: new_skin)
          fill_data(asset_id: asset_id, skin: skin, new_skin: new_skin)

          ActiveRecord::Base.transaction do
            new_skin.save
            create_log!(new_skin: new_skin)
          end
        end
      end

      def create_log!(new_skin:)
        Skins::Logs::Create.call(steam_price: new_skin.steam_price, skin: new_skin)
      end

      def fill_data(asset_id:, skin:, new_skin:)
        new_skin.steam_id = asset_id
        new_skin.image = image(skin: skin)
        new_skin.inspect_url = inspect_url(skin: skin, asset_id: asset_id)
        new_skin.exterior = exterior(skin: skin)
        new_skin.name_tag = name_tag(skin: skin)
        new_skin.has_name_tag = new_skin.name_tag.present?
        new_skin.steam_price = steam_price(skin_name: new_skin.market_name)
        new_skin.first_steam_price = new_skin.steam_price
        new_skin.stattrak = stattrak?(skin: skin)
        new_skin.sticker_name = sticker_name(skin: skin)
        new_skin.sticker_image = sticker_image(skin: skin)
        new_skin.has_sticker = new_skin.sticker_name.present? || new_skin.sticker_image.present?
        new_skin.expiration_date = expiration_date(class_id: skin['classid'])
      end

      def fill_basic_data(skin:, new_skin:)
        new_skin.name = skin['name']
        new_skin.market_name = skin['market_hash_name']
        new_skin.name_color = skin['name_color']
        new_skin.kind = skin['tags'].first['localized_tag_name']
        new_skin.gun_kind = skin['tags'].second['localized_tag_name']
        new_skin.steam_account = @steam_account
      end

      def asset_id(skin:)
        Steam::Skins::Assets::Find.call(inventory: @inventory, skin: skin)
      end

      def persisted_skin_available?(asset_id:)
        Skins::Find.call(steam_account: @steam_account, steam_id: asset_id, available: true)
      end

      def image(skin:)
        Steam::Skins::Assets::Images::Find.call(skin: skin)
      end

      def inspect_url(skin:, asset_id:)
        Steam::Skins::Assets::InspectUrl::Generate.call(steam_account: @steam_account, skin: skin, asset_id: asset_id)
      end

      def exterior(skin:)
        Steam::Skins::Assets::Exterior::Find.call(skin: skin)
      end

      def name_tag(skin:)
        Steam::Skins::Assets::NameTag::Find.call(skin: skin)
      end

      def steam_price(skin_name:)
        Steam::Skins::Assets::Price::Find.call(skin_name: skin_name)
      end

      def stattrak?(skin:)
        Steam::Skins::Assets::Stattrak::Find.call(skin: skin)
      end

      def sticker_name(skin:)
        Steam::Skins::Assets::Stickers::Names::Find.call(skin: skin)
      end

      def sticker_image(skin:)
        Steam::Skins::Assets::Stickers::Images::Find.call(skin: skin)
      end

      def expiration_date(class_id:)
        Steam::Skins::Assets::ExpirationDate::Find.call(class_id: class_id)
      end

      def ignore_skin_type?(skin:)
        type = skin['type']

        (@steam_account.types_to_reject.include?(type) && Skin::REJECT_TYPES.include?(type))
      end
    end
  end
end
