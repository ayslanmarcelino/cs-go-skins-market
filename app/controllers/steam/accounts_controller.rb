# frozen_string_literal: true

class Steam::AccountsController < ApplicationController
  load_and_authorize_resource

  def index
    @query = Steam::Account.accessible_by(current_ability).page(params[:page]).ransack(params[:q])

    @steam_accounts = @query.result(distinct: false)
  end
end
