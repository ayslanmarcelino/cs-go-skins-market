FactoryBot.define do
  factory :steam_account, class: 'Steam::Account' do
    description { 'Conta principal' }
    url { 'ayslanmarcelino' }
    steam_id { '76561198345749032' }

    user { create(:user, :with_person) }
    enterprise { user.person.enterprise }
  end
end
