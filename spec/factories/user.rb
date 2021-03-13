FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    nickname { Faker::Name }
    email    { Faker::Internet.free_email }
    password { 'aaaaa1' }
    password_confirmation { password }
    last_name { person.last.kanji }
    first_name { person.first.kanji }
    last_name_kana { person.last.katakana }
    first_name_kana { person.first.katakana }
    birthday { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
  end
end
