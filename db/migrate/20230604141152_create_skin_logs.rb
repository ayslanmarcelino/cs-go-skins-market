class CreateSkinLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :skin_logs do |t|
      t.float :steam_price
      t.references :skin, foreign_key: true

      t.timestamps
    end
  end
end
