module Inventories
  module Skins
    module Data
      class Base < ApplicationService
        def initialize(skin:)
          @skin = skin
        end

        private

        attr_accessor :skin
      end
    end
  end
end
