# frozen_string_literal: true

module Steam
  class Requisition < ApplicationService
    def initialize(steam_id:)
      @steam_id = steam_id
    end

    def call
      requisition
    end

    private

    def requisition
      response.body
    end

    def response
      @response ||= RestClient.get(endpoint)
    end

    def endpoint
      @endpoint ||= "https://steamcommunity.com/inventory/#{@steam_id}/730/2?l=brazilian"
    end
  end
end
