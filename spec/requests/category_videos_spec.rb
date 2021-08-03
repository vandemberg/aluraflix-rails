require 'rails_helper'

RSpec.describe "CategoryVideos", type: :request do
  describe "GET /index" do
    it "should list all videos related with the category" do
      category = Category.create({
        title: Faker::Sports::Football.competition,
        color: Faker::Color.hex_color
      })

      [1,2].each do
        Video.create({
          title: Faker::Superhero.descriptor,
          description: Faker::Lorem.sentence(word_count: 9),
          url: Faker::Internet.url,
          category_id: category.id,
        })
      end

      expect(Video.where(category_id: category.id ).count).to eq(2)
    end
  end
end
