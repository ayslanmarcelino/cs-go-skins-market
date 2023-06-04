# frozen_string_literal: true

module Skins
  module Logs
    class Create < ApplicationService
      def initialize(steam_price:, skin:)
        @steam_price = steam_price
        @skin = skin
      end

      def call
        create!
      end

      private

      def create!
        Skin::Log.create!(
          steam_price: @steam_price,
          skin: @skin
        )
      end
    end
  end
end
