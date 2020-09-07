FactoryBot.define do
  factory :user do
    family_name           {Faker::Name.last_name}
    first_name            {Faker::Name.first_name}
    family_name_kana      {Faker::Name.last_naem.yomi}
    first_name_kana       {Faker::Name.first_name.yomi}
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
  end
end