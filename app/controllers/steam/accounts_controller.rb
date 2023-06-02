# frozen_string_literal: true

class Steam::AccountsController < ApplicationController
  load_and_authorize_resource

  def index
    @steam_accounts = Steam::Account.accessible_by(current_ability)
  end
end
