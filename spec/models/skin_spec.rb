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
#  gun_kind          :string
#  has_name_tag      :boolean          default(FALSE)
#  has_sticker       :boolean          default(FALSE)
#  image             :string
#  inspect_url       :string
#  kind              :string
#  market_name       :string
#  name              :string
#  name_color        :string
#  name_tag          :string
#  sale_value        :float            default(0.0)
#  stattrak          :boolean          default(FALSE)
#  steam_price       :float            default(0.0)
#  sticker_image     :string           default([]), is an Array
#  sticker_name      :string           default("{}")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  steam_account_id  :bigint
#  steam_id          :bigint
#  transaction_id    :bigint
#
# Indexes
#
#  index_skins_on_steam_account_id  (steam_account_id)
#  index_skins_on_transaction_id    (transaction_id)
#
# Foreign Keys
#
#  fk_rails_...  (steam_account_id => steam_accounts.id)
#  fk_rails_...  (transaction_id => transactions.id)
#
require 'rails_helper'

RSpec.describe Skin, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:steam_account) }

    it { is_expected.to have_many(:logs) }
  end
end
