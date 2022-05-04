FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name            {'阿'}
    last_name             {'明'}
    first_name_kana       {'ア'}
    last_name_kana        {'ア'}
    birth_year            {'1984-12-12'}
  end
end