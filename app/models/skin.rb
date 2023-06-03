# == Schema Information
#
# Table name: skins
#
#  id                :bigint           not null, primary key
#  amount_paid       :float            default(0.0)
#  available         :boolean          default(TRUE)
#  csmoney_price     :float            default(0.0)
#  expiration_date   :datetime
#  exterior          :string
#  first_steam_price :float            default(0.0)
#  float             :float
#  gun_type          :string
#  has_name_tag      :boolean          default(FALSE)
#  image             :string
#  image_sticker     :string           default([]), is an Array
#  inspect_url       :string
#  market_name       :string
#  name              :string
#  name_color        :string
#  name_sticker      :string           default([]), is an Array
#  name_tag          :string
#  sale_value        :float            default(0.0)
#  stattrak          :boolean          default(FALSE)
#  steam_price       :float            default(0.0)
#  sticker           :boolean          default(FALSE)
#  type              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  steam_account_id  :bigint
#  steam_id          :bigint
#
# Indexes
#
#  index_skins_on_steam_account_id  (steam_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (steam_account_id => steam_accounts.id)
#
class Skin < ApplicationRecord
end
