FactoryBot.define do
  factory :video do
    title { Faker::Name.name }
    description { Faker::Lorem.sentence(word_count: 9) }
    url { Faker::Internet.url }
    category
  end
end
