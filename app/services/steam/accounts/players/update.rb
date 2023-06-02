module Steam
  module Accounts
    module Players
      class Update < ApplicationService
        def initialize(steam_account:, persisted: false)
          @steam_account = steam_account
          @persisted = persisted
        end

        def call
          update!
        end

        private

        def update!
          return if steam_account_params.blank?

          @steam_account.update(
            steam_id: steam_account_params['steamid'],
            profile_url: steam_account_params['profileurl'],
            nickname: steam_account_params['personaname'],
            avatar_url: steam_account_params['avatar'],
            avatar_medium_url: steam_account_params['avatarmedium'],
            avatar_full_url: steam_account_params['avatarfull'],
            real_name: steam_account_params['realname']
          )
        end

        def steam_account_params
          @steam_account_params ||= Steam::Accounts::Players::Find.call(steam_custom_id: steam_id, persisted: @persisted)
        end

        def steam_id
          @steam_id ||= @persisted ? @steam_account.steam_id : @steam_account.steam_custom_id
        end
      end
    end
  end
end
