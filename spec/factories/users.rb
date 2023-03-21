FactoryBot.define do
  factory :user do
    peason = Gimei.name

    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    password { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name { peason.first.kanji }
    last_name { peason.last.kanji }
    first_name_kana { peason.first.katakana }
    last_name_kana { peason.last.katakana }
    birthday { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end
