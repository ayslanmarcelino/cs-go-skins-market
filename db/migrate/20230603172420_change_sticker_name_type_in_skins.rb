class ChangeStickerNameTypeInSkins < ActiveRecord::Migration[7.0]
  def change
    change_column(:skins, :sticker_name, :string)
  end
end
