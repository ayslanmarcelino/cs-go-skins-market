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

      def load_data
        @data = ::Inventories::Skins::Data::SteamWebApi.new(skin: @skin)
      end

      def persisted_skin_available?
        ::Skins::Find.call(steam_account: @steam_account, steam_id: @asset_id, available: true)
      end

      def ignore_skin_type?
        type = @data.type

        (@steam_account.types_to_reject.include?(type) && Skin::REJECT_TYPES.include?(type))
      end

      def fill_basic_data
        @new_skin = Skin.new
        @new_skin.name = @data.name
        @new_skin.market_name = @data.market_name
        @new_skin.name_color = @data.name_color
        @new_skin.kind = @data.kind
        @new_skin.gun_kind = @data.gun_kind
        @new_skin.steam_account = @steam_account
      end

      def fill_data
        @new_skin.steam_id = @asset_id
        @new_skin.image = @data.image
        @new_skin.inspect_url = @data.inspect_url
        @new_skin.exterior = @data.exterior
        @new_skin.name_tag = @data.name_tag
        @new_skin.has_name_tag = @new_skin.name_tag.present?
        @new_skin.steam_price = @data.steam_price
        @new_skin.first_steam_price = @new_skin.steam_price
        @new_skin.stattrak = @data.stattrak
        @new_skin.sticker_name = @data.sticker_name
        @new_skin.sticker_image = @data.sticker_image
        @new_skin.has_sticker = @new_skin.sticker_name.present? || @new_skin.sticker_image.present?
        @new_skin.expiration_date = @data.expiration_date
      end

      def create_log!
        ::Skins::Logs::Create.call(steam_price: @new_skin.steam_price, skin: @new_skin)
      end

      def create!
        skins.each do |skin|
          @skin = skin
          load_data

          @asset_id = @data.asset_id

          next if !@data.marketable || ignore_skin_type?
          next if persisted_skin_available?

          fill_basic_data
          fill_data

          ActiveRecord::Base.transaction do
            @new_skin.save
            create_log!
          end
        end
      end
    end
  end
end
