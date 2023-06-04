module Steam
  module Skins
    module Assets
      class Find < ApplicationService
        def initialize(inventory:, skin:)
          @inventory = inventory
          @skin = skin
        end

        def call
          find
        end

        private

        def find
          @inventory.find { |item| item['classid'] == @skin['classid'] }&.fetch('assetid', nil)
        end
      end
    end
  end
end
