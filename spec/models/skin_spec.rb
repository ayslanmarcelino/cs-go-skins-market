# == Schema Information
#
# Table name: skins
#
#  id                   :bigint           not null, primary key
#  amount_paid          :float            default(0.0)
#  available            :boolean          default(TRUE)
#  csmoney_price        :float            default(0.0)
#  description          :string
#  description_color    :string
#  description_name_tag :string
#  expiration_date      :datetime
#  exterior             :string
#  first_steam_price    :float            default(0.0)
#  float                :float
#  gun_type             :string
#  image                :string
#  image_sticker        :string           default([]), is an Array
#  inspect_url          :string
#  name_sticker         :string           default([]), is an Array
#  name_tag             :boolean          default(FALSE)
#  sale_value           :float            default(0.0)
#  stattrak             :boolean          default(FALSE)
#  steam_price          :float            default(0.0)
#  sticker              :boolean          default(FALSE)
#  type                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  steam_account_id     :bigint
#  steam_id             :bigint
#
# Indexes
#
#  index_skins_on_steam_account_id  (steam_account_id)
#
# Foreign Keys
#
#  fk_rails_...  (steam_account_id => steam_accounts.id)
#
require 'rails_helper'

RSpec.describe Skin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
