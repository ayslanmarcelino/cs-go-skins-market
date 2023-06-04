module Steam
  module Skins
    module Assets
      module ExpirationDate
        class Find < ApplicationService
          def initialize(class_id:)
            @class_id = class_id
          end

          def call
            find
          end

          private

          def find
            skin['cache_expiration']&.to_datetime
          end

          def skin
            @skin ||= Steam::AssetClass::Information::Find.call(class_id: @class_id)
          end
        end
      end
    end
  end
end
