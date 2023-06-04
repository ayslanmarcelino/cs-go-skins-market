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
                if description['value'].include?('sticker_info') && description['value'].include?('Adesivo')
                  return description['value'].match(%r{Adesivo: (.*?)</center>})[1]
                elsif description['value'].include?('sticker_info') && description['value'].include?('Emblema')
                  return description['value'].match(%r{Emblema: (.*?)</center>})[1]
                end
              end

              nil
            end
          end
        end
      end
    end
  end
end
