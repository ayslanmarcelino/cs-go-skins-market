class TransactionsController < ApplicationController
  def index
    @query = Transaction.includes(:transaction_type, :skins)
                        .order(created_at: :desc)
                        .accessible_by(current_ability)
                        .page(params[:page])
                        .ransack(params[:q])

    @transactions = @query.result(distinct: false)
  end
end
