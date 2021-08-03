require 'rails_helper'

RSpec.describe "CategoryVideos", type: :request do
  let(:token) {
    JsonWebToken.encode(user_id: create(:user).id)
  }

  let(:valid_headers) {
    {
      Authorization: "Bearer #{token}"
    }
  }

  describe "GET /index" do
    it "should list all videos related with the category" do
      category = create(:category)
      count_videos = 5

      FactoryBot.create_list(:video, count_videos, category_id: category.id)

      get "/categories/#{category.id}/videos", headers: valid_headers, as: :json

      expect(JSON.parse(response.body).length).to eq(5)
    end
  end
end
