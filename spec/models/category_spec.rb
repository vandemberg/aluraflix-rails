require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Should persiste in database" do
    it "valid attributes" do
      category = Category.create({
        title: Faker::Sports::Football.competition,
        color: Faker::Color.hex_color,
      })

      expect(category.persisted?).to be(true)
    end
  end

  describe "Should alert about validations" do
    it "title empty" do
      category = Category.create({
        color: Faker::Color.hex_color,
      })

      expect(category.persisted?).to be(false)
    end

    it "color empty" do
      category = Category.create({
        color: Faker::Color.hex_color,
      })

      expect(category.persisted?).to be(false)
    end
  end
end
