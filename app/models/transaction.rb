# == Schema Information
#
# Table name: transactions
#
#  id                  :bigint           not null, primary key
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
class Transaction < ApplicationRecord
  belongs_to :transaction_type, class_name: 'Transaction::Type'
  belongs_to :owner, class_name: 'User'

  validates :value, :transaction_type, :owner, presence: true
end
