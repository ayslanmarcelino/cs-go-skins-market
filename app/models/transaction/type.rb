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

  validates :description, presence: true
  validates :description, uniqueness: { scope: :enterprise_id }

  before_validation :capitalize_description

  def self.permitted_params
    [
      :id,
      :description,
      :enterprise_id
    ]
  end

  def capitalize_description
    self.description = description.capitalize
  end

  def increment!
    self.counter += 1
    save
  end
end
