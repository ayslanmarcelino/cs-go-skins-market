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
#  real_name         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  enterprise_id     :bigint
#  steam_custom_id   :string
#  steam_id          :string
#  user_id           :bigint
#
# Indexes
#
#  index_steam_accounts_on_enterprise_id  (enterprise_id)
#  index_steam_accounts_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (user_id => users.id)
#
class Steam::Account < ApplicationRecord
  belongs_to :user
  belongs_to :enterprise

  validates :steam_id, :steam_custom_id, presence: true
  validates :steam_id, :steam_custom_id, uniqueness: { scope: [:user_id, :enterprise_id] }
end
