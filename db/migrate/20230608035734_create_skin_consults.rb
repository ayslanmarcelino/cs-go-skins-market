class CreateSkinConsults < ActiveRecord::Migration[7.0]
  def change
    create_table :skin_consults do |t|
      t.string :steam_id_decimal
      t.jsonb :raw_data, default: {}

      t.timestamps
    end
  end
end
