module Steam
  module Skins
    module Assets
      module Stickers
        module Names
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
                  return description['value'].match(/Adesivo: (.*?)<\/center>/)[1]
                end
              end
            end
          end
        end
      end
    end
  end
end
