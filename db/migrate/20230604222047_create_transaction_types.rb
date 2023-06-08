class CreateTransactionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_types do |t|
      t.string :description
      t.integer :counter, default: 0

      t.references :enterprise, foreign_key: true

      t.timestamps
    end
  end
end
