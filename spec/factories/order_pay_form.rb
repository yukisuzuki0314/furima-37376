FactoryBot.define do
  factory :order_pay_form do
    token            { 'tok_abcdefghijk00000000000000000' }
    postal_code      { '123-1234' }
    prefecture_id    { 2 }
    city             { '横浜' }
    addresses        { 'あおやま1-1-1' }
    building         { 'ビル' }
    phone_number     { '09012345678' }
  end
end
