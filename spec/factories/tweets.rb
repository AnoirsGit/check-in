FactoryBot.define do
  factory :tweet do
    body { "MyString" }
    likes { 1 }
    retweets { 1 }
  end
end
