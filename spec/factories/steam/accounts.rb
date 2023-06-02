FactoryBot.define do
  factory :steam_account, class: 'Steam::Account' do
    steam_id { '76561198345749032' }
    steam_custom_id { 'ayslanmarcelino' }
    profile_url { 'https://steamcommunity.com/id/ayslanmarcelino/' }
    nickname { '@pingo.rifas' }
    avatar_url { 'https://avatars.steamstatic.com/400d9312022a914738e099c7aeed856e942e059c.jpg' }
    avatar_medium_url { 'https://avatars.steamstatic.com/400d9312022a914738e099c7aeed856e942e059c_medium.jpg' }
    avatar_full_url { 'https://avatars.steamstatic.com/400d9312022a914738e099c7aeed856e942e059c_full.jpg' }
    real_name { 'Ayslan Marcelino' }

    user { create(:user, :with_person) }
    enterprise { user.person.enterprise }
  end
end
