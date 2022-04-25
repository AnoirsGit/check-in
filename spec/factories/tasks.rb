FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyString" }
    deadline { "2022-04-16" }
    status { 1 }
  end
end
