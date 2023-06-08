FactoryBot.define do
  factory :transaction do
    value { rand(30..200) }
    identifier { rand(1..100) }

    transaction_type { create(:transaction_type) }
    owner { create(:user, :with_person) }

    trait :pending do
      aasm_state { :pending }
    end

    trait :finished do
      aasm_state { :finished }
    end
  end
end
