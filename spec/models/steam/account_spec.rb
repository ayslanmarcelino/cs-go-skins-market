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
require 'rails_helper'

RSpec.describe Steam::Account, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:enterprise) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:steam_id) }
    it { is_expected.to validate_uniqueness_of(:description).scoped_to(:user_id, :enterprise_id) }
    it { is_expected.to validate_uniqueness_of(:url).scoped_to(:user_id, :enterprise_id) }
    it { is_expected.to validate_uniqueness_of(:steam_id).scoped_to(:user_id, :enterprise_id) }
  end
end
