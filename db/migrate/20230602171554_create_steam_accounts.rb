class CreateSteamAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :steam_accounts do |t|
      t.string :steam_id
      t.string :steam_custom_id
      t.string :profile_url
      t.string :nickname
      t.string :avatar_url
      t.string :avatar_medium_url
      t.string :avatar_full_url
      t.string :real_name
      t.boolean :active, default: true

      t.references :owner, foreign_key: { to_table: :users }
      t.references :enterprise, foreign_key: true

      t.timestamps
    end
  end
end
