FactoryBot.define do
  factory :transaction do
    value { rand(30..200) }

    transaction_type { create(:transaction_type) }
    owner { create(:user, :with_person) }
  end
end
