class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @query = Transaction.includes(:transaction_type, :skins)
                        .order(created_at: :desc)
                        .accessible_by(current_ability)
                        .page(params[:page])
                        .ransack(params[:q])

    @transactions = @query.result(distinct: false)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    
  end

  private

  def transaction_params
    params.require(:transaction)
          .permit(Transaction.permitted_params)
          .merge(owner: current_user)
  end
end
