module Steam
  module Skins
    module Assets
      module Stattrak
        class Find < ApplicationService
          def initialize(skin:)
            @skin = skin
          end

          def call
            find
          end

          private

          def find
            @skin['descriptions'].each do |description|
              description['value'].include?('StatTrak')
            end
          end
        end
      end
    end
  end
end
