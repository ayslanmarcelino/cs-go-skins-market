module Steam
  module Skins
    module Assets
      module Exterior
        class Find < ApplicationService
          def initialize(skin:)
            @skin = skin
          end

          def call
            find
          end

          private

          def find
            return 'Nenhum' if @skin['descriptions'].blank?

            @skin['descriptions'].each do |description|
              return description['value'].partition('Exterior: ').last if description['value'].include?('Exterior:')
            end
          end
        end
      end
    end
  end
end
