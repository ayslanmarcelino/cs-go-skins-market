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
require 'rails_helper'

RSpec.describe Steam::Account, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:enterprise) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:steam_url) }
    it { is_expected.to validate_presence_of(:steam_id) }
    it { is_expected.to validate_uniqueness_of(:steam_url).scoped_to(:user_id, :enterprise_id) }
    it { is_expected.to validate_uniqueness_of(:steam_id).scoped_to(:user_id, :enterprise_id) }
  end
end
