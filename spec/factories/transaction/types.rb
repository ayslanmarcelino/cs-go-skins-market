FactoryBot.define do
  factory :transaction_type, class: 'Transaction::Type' do
    description { 'Rifa' }

    enterprise { create(:enterprise) }
  end
end
