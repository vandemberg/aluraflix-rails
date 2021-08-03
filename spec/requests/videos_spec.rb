require 'rails_helper'

RSpec.describe "/videos", type: :request do
  let(:category_id) {
    Category.create({
      title: Faker::Sports::Football.competition,
      color: Faker::Color.hex_color
    }).id
  }

  let(:valid_attributes) {
    {
      title: Faker::Superhero.descriptor,
      description: Faker::Lorem.sentence(word_count: 9),
      url: Faker::Internet.url,
      category_id: category_id
    }
  }

  let(:invalid_attributes) {
    {
      title: '',
      description: '',
      url: '',
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Video.create! valid_attributes
      get videos_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it "should get videos from search" do
      Video.create! valid_attributes

      [1,2,3,4].each do |key|
        Video.create!({
          title: "Teste #{key}",
          description: Faker::Lorem.sentence(word_count: 9),
          url: Faker::Internet.url,
          category_id: category_id
        })
      end

      get "#{videos_url}?search=Teste", headers: valid_headers, as: :json
      expect(JSON.parse(response.body).length).to eq(4)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      video = Video.create! valid_attributes
      get video_url(video), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Video" do
        expect {
          post videos_url,
               params: { video: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Video, :count).by(1)
      end

      it "renders a JSON response with the new video" do
        post videos_url,
             params: { video: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Video" do
        expect {
          post videos_url,
               params: { video: invalid_attributes }, as: :json
        }.to change(Video, :count).by(0)
      end

      it "renders a JSON response with errors for the new video" do
        post videos_url,
             params: { video: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          title: Faker::Superhero.descriptor,
          description: Faker::Lorem.sentence(word_count: 9),
          url: Faker::Internet.url
        }
      }

      it "updates the requested video" do
        video = Video.create! valid_attributes
        patch video_url(video),
              params: { video: new_attributes }, headers: valid_headers, as: :json
        video.reload

        expect(video.title).to eq(new_attributes[:title])
        expect(video.description).to eq(new_attributes[:description])
        expect(video.url).to eq(new_attributes[:url])
      end

      it "renders a JSON response with the video" do
        video = Video.create! valid_attributes
        patch video_url(video),
              params: { video: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json; charset=utf-8"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the video" do
        video = Video.create! valid_attributes
        patch video_url(video),
              params: { video: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested video" do
      video = Video.create! valid_attributes
      expect {
        delete video_url(video), headers: valid_headers, as: :json
      }.to change(Video, :count).by(-1)
    end
  end
end
