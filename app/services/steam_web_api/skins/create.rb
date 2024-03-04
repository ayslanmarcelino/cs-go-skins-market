module SteamWebApi
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

      def skins
        @skins ||= @consult.raw_data
      end

      def fill_basic_data(skin:, new_skin:)
        new_skin.name = skin.dig('marketname')
        new_skin.market_name = skin.dig('markethashname')
        new_skin.name_color = skin.dig('color')
        new_skin.kind = skin.dig('tags')&.first&.dig('localized_tag_name')
        new_skin.gun_kind = skin.dig('tags')&.second&.dig('localized_tag_name')
        new_skin.steam_account = @steam_account
      end

      def create!
        skins.each do |skin|
          asset_id = asset_id(skin: skin)

          next if !skin.dig('marketable') || ignore_skin_type?(skin: skin)
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
        ::Skins::Logs::Create.call(steam_price: new_skin.steam_price, skin: new_skin)
      end

      def fill_data(asset_id:, skin:, new_skin:)
        new_skin.steam_id = asset_id
        new_skin.image = image(skin: skin)
        new_skin.inspect_url = inspect_url(skin: skin)
        new_skin.exterior = exterior(skin: skin)
        new_skin.name_tag = name_tag(skin: skin)
        new_skin.has_name_tag = new_skin.name_tag.present?
        new_skin.steam_price = steam_price(skin: skin)
        new_skin.first_steam_price = new_skin.steam_price
        new_skin.stattrak = stattrak?(skin: skin)
        new_skin.sticker_name = sticker_name(skin: skin)
        new_skin.sticker_image = sticker_image(skin: skin)
        new_skin.has_sticker = new_skin.sticker_name.present? || new_skin.sticker_image.present?
        new_skin.expiration_date = expiration_date(class_id: skin['classid'])
      end

      def asset_id(skin:)
        skin.dig('assetid')
      end

      def persisted_skin_available?(asset_id:)
        ::Skins::Find.call(steam_account: @steam_account, steam_id: asset_id, available: true)
      end

      def image(skin:)
        skin.dig('image')
      end

      def inspect_url(skin:)
        skin.dig('inspectlink')
      end

      def exterior(skin:)
        Steam::Skins::Assets::Exterior::Find.call(skin: skin)
      end

      def name_tag(skin:)
        skin.dig('nametag')
      end

      def steam_price(skin:)
        skin.dig('pricelatest')
      end

      def stattrak?(skin:)
        skin.dig('isstattrak')
      end

      def sticker_name(skin:)
        # TODO: verificar

        # Steam::Skins::Assets::Stickers::Names::Find.call(skin: skin)
      end

      def sticker_image(skin:)
        # TODO: verificar

        # Steam::Skins::Assets::Stickers::Images::Find.call(skin: skin)
      end

      def expiration_date(class_id:)
        # TODO: verificar

        # Steam::Skins::Assets::ExpirationDate::Find.call(class_id: class_id)
      end

      def ignore_skin_type?(skin:)
        type = skin['type']

        (@steam_account.types_to_reject.include?(type) && Skin::REJECT_TYPES.include?(type))
      end
    end
  end
end
