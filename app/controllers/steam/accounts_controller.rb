# frozen_string_literal: true

class Steam::AccountsController < ApplicationController
  def index
    @steam_accounts = Steam::Account.all
  end
end
