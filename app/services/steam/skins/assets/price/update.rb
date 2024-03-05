module Steam
  module Skins
    module Assets
      module Price
        class Update < ApplicationService
          def initialize(current_user:, steam_account:)
            @current_user = current_user
            @steam_account = steam_account
          end

          def call
            update!
          end

          private

          def update!
            ::Skins::Prices::Update.call(steam_account: @steam_account, skins: skins, inventory: inventory)
          end

          def inventory
            @inventory ||= consult.raw_data['assets']
          end

          def skins
            @skins ||= consult.raw_data['descriptions'].reverse
          end

          def consult
            @consult ||= Skin::Consult.find_by(steam_id_decimal: @steam_account.steam_id, source_cd: :inventory)
          end
        end
      end
    end
  end
end
