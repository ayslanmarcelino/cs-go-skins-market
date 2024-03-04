# == Schema Information
#
# Table name: steam_accounts
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  avatar_full_url   :string
#  avatar_medium_url :string
#  avatar_url        :string
#  nickname          :string
#  profile_url       :string
#  provider_cd       :string           default("steam")
#  real_name         :string
#  types_to_reject   :string           default([]), is an Array
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  enterprise_id     :bigint
#  owner_id          :bigint
#  steam_custom_id   :string
#  steam_id          :string
#
# Indexes
#
#  index_steam_accounts_on_enterprise_id  (enterprise_id)
#  index_steam_accounts_on_owner_id       (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (owner_id => users.id)
#
class Steam::Account < ApplicationRecord
  PROVIDERS = [:steam, :steam_web_api].freeze

  belongs_to :owner, class_name: 'User'
  belongs_to :enterprise

  validates :steam_custom_id, presence: true
  validates :steam_custom_id, uniqueness: { scope: [:owner_id, :enterprise_id] }

  as_enum :provider, PROVIDERS, prefix: true, map: :string

  before_validation :downcase_steam_custom_id

  def self.permitted_params
    [
      :id,
      :active,
      :steam_custom_id,
      :enterprise_id,
      :owner_id
    ]
  end

  def downcase_steam_custom_id
    self.steam_custom_id = steam_custom_id&.downcase
  end

  def formatted_name
    "#{steam_id} | #{steam_custom_id}"
  end
end
