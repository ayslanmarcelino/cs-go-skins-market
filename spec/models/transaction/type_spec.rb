# == Schema Information
#
# Table name: transaction_types
#
#  id            :bigint           not null, primary key
#  counter       :integer          default(0)
#  description   :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint
#
# Indexes
#
#  index_transaction_types_on_enterprise_id  (enterprise_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#
require 'rails_helper'

RSpec.describe Transaction::Type, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:enterprise) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_uniqueness_of(:description).scoped_to(:enterprise_id) }
  end
end
