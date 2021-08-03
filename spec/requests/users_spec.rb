require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:valid_attributes) {
    user = build(:user)
    {
      name: user.name,
      username: user.username,
      email: user.email,
      password: "password",
      password_confirmation: "password"
    }
  }

  let(:invalid_attributes) {
    user = build(:user)
    {
      name: user.name,
      username: user.username,
      email: user.email,
      password: "password_wrong",
      password_confirmation: "password"
    }
  }

  describe "POST /users" do
    it "should create a user" do
      post "/users", { params: valid_attributes}

      expect(response).to be_successful
      expect(JSON.parse(response.body)).to have_key("name")
      expect(JSON.parse(response.body)).to have_key("email")
      expect(JSON.parse(response.body)).to have_key("username")
    end
  end

  describe "POST /users" do
    it "should create a user" do
      post "/users", { params: invalid_attributes}

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)).to have_key("errors")
    end
  end
end
