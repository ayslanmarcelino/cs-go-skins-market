module Skins
  class Find < ApplicationService
    def initialize(steam_account:, steam_id:, available:)
      @steam_account = steam_account
      @steam_id = steam_id
      @available = available
    end

    def call
      find
    end

    private

    def find
      Skin.find_by(steam_account: @steam_account, steam_id: @steam_id, available: @available)
    end
  end
end
