require 'rails_helper'

RSpec.describe "/categories", type: :request do
  let(:valid_attributes) {
    {
      title: Faker::Sports::Football.competition,
      color: Faker::Color.hex_color,
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      color: nil,
    }
  }

  let(:token) {
    JsonWebToken.encode(user_id: create(:user).id)
  }

  let(:valid_headers) {
    {
      Authorization: "Bearer #{token}"
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      count_categories = 12
      FactoryBot.create_list(:category, count_categories)

      get categories_url, headers: valid_headers, as: :json

      expect(response).to be_successful
      expect(JSON.parse(response.body).length).to eq(5)
    end

    it "renders a successful response" do
      count_categories = 12
      FactoryBot.create_list(:category, count_categories)

      get "#{categories_url}?page=2", headers: valid_headers, as: :json

      expect(response).to be_successful
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      category = Category.create! valid_attributes
      get category_url(category), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Category" do
        expect {
          post categories_url,
               params: { category: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Category, :count).by(1)
      end

      it "renders a JSON response with the new category" do
        post categories_url,
             params: { category: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Category" do
        expect {
          post categories_url,
               params: { category: invalid_attributes }, as: :json
        }.to change(Category, :count).by(0)
      end

      it "renders a JSON response with errors for the new category" do
        post categories_url,
             params: { category: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: Faker::Sports::Football.competition,
          color: Faker::Color.hex_color,
        }
      }

      it "updates the requested category" do
        category = Category.create! valid_attributes
        patch category_url(category),
              params: { category: new_attributes }, headers: valid_headers, as: :json
        category.reload

        expect(category.title).to eq(new_attributes[:title])
        expect(category.color).to eq(new_attributes[:color])
      end

      it "renders a JSON response with the category" do
        category = Category.create! valid_attributes
        patch category_url(category),
              params: { category: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the category" do
        category = Category.create! valid_attributes
        patch category_url(category),
              params: { category: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested category" do
      category = Category.create! valid_attributes
      expect {
        delete category_url(category), headers: valid_headers, as: :json
      }.to change(Category, :count).by(-1)
    end
  end
end
