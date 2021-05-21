FactoryBot.define do
  factory :post do
    user_id { 1 }
    body { "MyText" }
    title { "MyString" }
  end
end
