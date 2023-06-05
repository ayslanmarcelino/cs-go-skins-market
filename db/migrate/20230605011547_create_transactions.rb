class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.float :value
      t.string :aasm_state, default: 'pending'
      t.integer :identifier

      t.references :owner, foreign_key: { to_table: :users }
      t.references :transaction_type, foreign_key: true

      t.timestamps
    end
  end
end
