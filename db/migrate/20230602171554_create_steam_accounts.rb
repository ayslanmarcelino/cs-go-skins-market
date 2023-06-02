class CreateSteamAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :steam_accounts do |t|
      t.string :steam_id
      t.string :steam_url
      t.string :nickname
      t.string :avatar_url
      t.string :avatar_medium_url
      t.string :avatar_full_url
      t.string :real_name

      t.references :user, foreign_key: true
      t.references :enterprise, foreign_key: true

      t.timestamps
    end
  end
end
