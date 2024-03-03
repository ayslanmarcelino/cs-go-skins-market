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
require 'rails_helper'

RSpec.describe Steam::Account, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:enterprise) }
    it { is_expected.to belong_to(:owner) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:steam_custom_id) }
  end
end
