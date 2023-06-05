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
    @transaction = Transaction.new(transaction_params)

    if @transaction.valid?
      ActiveRecord::Base.transaction do
        @transaction.transaction_type.increment!
        @transaction.identifier = @transaction.transaction_type.counter
        @transaction.save
      end

      redirect_success(path: transactions_path, action: 'criada') if @transaction.persisted?
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def transaction_params
    params.require(:transaction)
          .permit(Transaction.permitted_params)
          .merge(owner: current_user)
  end

  def redirect_success(path:, action:)
    redirect_to(path)
    flash[:success] = "Transação #{action} com sucesso."
  end
end
