# == Schema Information
#
# Table name: transactions
#
#  id                  :bigint           not null, primary key
#  aasm_state          :string           default("pending")
#  amount_paid         :float            default(0.0)
#  identifier          :integer
#  value               :float
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  owner_id            :bigint
#  transaction_type_id :bigint
#
# Indexes
#
#  index_transactions_on_owner_id             (owner_id)
#  index_transactions_on_transaction_type_id  (transaction_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#  fk_rails_...  (transaction_type_id => transaction_types.id)
#
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to belong_to(:transaction_type) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:aasm_state) }
    it { is_expected.to validate_presence_of(:owner) }
    it { is_expected.to validate_presence_of(:transaction_type) }
  end
end
