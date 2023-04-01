FactoryBot.define do
  factory :order_residence do
    address = Gimei.address

    postal_code { Faker::Number.leading_zero_number(digits: 3) + '-' + Faker::Number.leading_zero_number(digits: 4) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { address.city.kanji + address.town.kanji }
    addresses { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.decimal_part(digits: 11) }
  end
end
