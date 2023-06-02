# == Schema Information
#
# Table name: steam_accounts
#
#  id            :bigint           not null, primary key
#  description   :string
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint
#  steam_id      :bigint
#  user_id       :bigint
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

  validates :url, :steam_id, presence: true
  validates :url, :steam_id, uniqueness: { scope: [:user_id, :enterprise_id] }
end
