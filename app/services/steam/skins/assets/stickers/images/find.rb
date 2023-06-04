module Steam
  module Skins
    module Assets
      module Stickers
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
              return if @skin['descriptions'].blank?

              @skin['descriptions'].each do |description|
                if description['value'].include?('sticker_info')
                  return description['value'].scan(/https?:\/\/[\S]+?png/)
                end
              end
            end
          end
        end
      end
    end
  end
end
