FactoryBot.define do
  factory :user do
    family_name           {Gimei.name.last.kanji}
    first_name            {Gimei.name.first.kanji}
    family_name_kana      {Gimei.name.last.katakana}
    first_name_kana       {Gimei.name.first.katakana}
    nick_name             {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    birth_date            {Faker::Date.in_date_period(year: 2018, month: 2)}
  end
end