FactoryBot.define do
  factory :order_address do
    token         {Faker::Code.asin}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    city          {Gimei.city.kanji}
    address       {Gimei.town.kanji}
    building      {Gimei.town.kanji}
    tel           {Faker::Number.leading_zero_number(digits: 10) }
    postal_code   {'123-4567'}
  end
end
