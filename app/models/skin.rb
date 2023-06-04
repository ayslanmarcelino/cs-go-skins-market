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
  REJECT_TYPES = [
    'Grafite (Nível Básico)',
    'Recipiente (Nível Básico)',
    'Ferramenta (Nível Básico)'
  ].freeze

  belongs_to :steam_account, class_name: 'Steam::Account'

  validates :steam_id, uniqueness: { scope: [:steam_account_id] }

  has_many :logs

  def self.permitted_params
    [
      :id,
      :float,
      :csmoney_price,
      :sale_value
    ]
  end
end
