class CreateSkins < ActiveRecord::Migration[7.0]
  def change
    create_table :skins do |t|
      t.bigint :steam_id
      t.string :description
      t.string :description_color
      t.string :exterior
      t.string :image
      t.string :inspect_url
      t.string :description_name_tag
      t.string :type
      t.string :gun_type

      t.float :float
      t.float :steam_price, default: 0
      t.float :first_steam_price, default: 0
      t.float :csmoney_price, default: 0
      t.float :amount_paid, default: 0
      t.float :sale_value, default: 0

      t.boolean :stattrak, default: false
      t.boolean :sticker, default: false
      t.boolean :available, default: true
      t.boolean :name_tag, default: false

      t.string :name_sticker, array: true, default: []
      t.string :image_sticker, array: true, default: []

      t.datetime :expiration_date

      t.references :steam_account, foreign_key: true

      t.timestamps
    end
  end
end
