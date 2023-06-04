# == Schema Information
#
# Table name: transaction_types
#
#  id          :bigint           not null, primary key
#  counter     :integer          default(0)
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Transaction::Type < ApplicationRecord
end
