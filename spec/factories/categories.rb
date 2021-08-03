FactoryBot.define do
  factory :category do
    title { Faker::Sports::Football.competition }
    color { Faker::Color.hex_color }
  end
end
