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
class Transaction::Type < ApplicationRecord
  belongs_to :enterprise

  validates :description, uniqueness: { scope: :enterprise }
end
