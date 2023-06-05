# == Schema Information
#
# Table name: transactions
#
#  id                  :bigint           not null, primary key
#  aasm_state          :string           default("pending")
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
class Transaction < ApplicationRecord
  include Transactions

  STATES = [
    :pending,
    :finished
  ].freeze

  belongs_to :transaction_type, class_name: 'Transaction::Type'
  belongs_to :owner, class_name: 'User'

  validates :value, :aasm_state, :identifier, :transaction_type, :owner, presence: true
  validates :identifier, uniqueness: { scope: [:transaction_type, :owner] }

  as_enum :state, STATES, map: :string, source: :aasm_state

  has_many :skins
  has_many :kind, class_name: 'Transaction::Type'

  def self.permitted_params
    [
      :id,
      :value
    ]
  end

  def amount_paid
    skins.sum(&:amount_paid)
  end

  def profit
    value - amount_paid
  end
end
