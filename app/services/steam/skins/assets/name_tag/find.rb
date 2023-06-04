module Steam
  module Skins
    module Assets
      module NameTag
        class Find < ApplicationService
          def initialize(skin:)
            @skin = skin
          end

          def call
            find
          end

          private

          def find
            return if name_tag.blank?

            name_tag.first.partition('Etiqueta de Nome: ').last.gsub(/[\\\"]/, '')
          end

          def name_tag
            @skin['fraudwarnings']
          end
        end
      end
    end
  end
end
