class CreateSteamAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :steam_accounts do |t|
      t.string :description
      t.bigint :steam_id
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
