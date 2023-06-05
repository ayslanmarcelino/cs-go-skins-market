class Transaction::TypesController < ApplicationController
  load_and_authorize_resource

  def new
    @transaction_type = Transaction::Type.new
  end

  def create
    @transaction_type = Transaction::Type.new(type_params)

    if @transaction_type.save
      redirect_success(path: transactions_path, action: 'criada')
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def type_params
    params.require(:transaction_type)
          .permit(Transaction::Type.permitted_params)
          .merge(enterprise: current_user.current_enterprise)
  end

  def redirect_success(path:, action:)
    redirect_to(path)
    flash[:success] = "Tipo de transação #{action} com sucesso."
  end
end
