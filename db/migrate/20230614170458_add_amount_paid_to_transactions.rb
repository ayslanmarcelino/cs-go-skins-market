class AddAmountPaidToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :amount_paid, :float, default: 0.0
  end
end
