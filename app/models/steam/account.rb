# == Schema Information
#
# Table name: steam_accounts
#
#  id                :bigint           not null, primary key
#  avatar_full_url   :string
#  avatar_medium_url :string
#  avatar_url        :string
#  nickname          :string
#  real_name         :string
#  steam_url         :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  enterprise_id     :bigint
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

  validates :steam_id, :steam_url, presence: true
  validates :steam_id, :steam_url, uniqueness: { scope: [:user_id, :enterprise_id] }
end
