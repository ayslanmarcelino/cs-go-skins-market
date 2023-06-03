class CreateSkins < ActiveRecord::Migration[7.0]
  def change
    create_table :skins do |t|
      t.bigint :steam_id
      t.string :name
      t.string :market_name
      t.string :name_color
      t.string :exterior
      t.string :image
      t.string :inspect_url
      t.string :name_tag
      t.string :kind
      t.string :gun_kind

      t.float :float
      t.float :steam_price, default: 0
      t.float :first_steam_price, default: 0
      t.float :csmoney_price, default: 0
      t.float :amount_paid, default: 0
      t.float :sale_value, default: 0

      t.boolean :stattrak, default: false
      t.boolean :has_sticker, default: false
      t.boolean :available, default: true
      t.boolean :has_name_tag, default: false

      t.string :sticker_name, array: true, default: []
      t.string :sticker_image, array: true, default: []

      t.datetime :expiration_date

      t.references :steam_account, foreign_key: true

      t.timestamps
    end
  end
end
