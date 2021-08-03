FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { "#{Faker::Name.prefix} #{Faker::Name.last_name}" }
    email { Faker::Internet.email }
    password { "password" }
  end
end
