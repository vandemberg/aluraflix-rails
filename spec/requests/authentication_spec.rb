require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "POST /login" do
    it "should return a valid token" do
      user = create(:user)

      post "/login", { params: { email: user.email, password: "password" }}

      expect(response).to be_successful
      expect(JSON.parse(response.body)).to have_key("token")
    end

    it "should not authenticate" do
      user = create(:user)
      post "/login", { params: { email: user.email, password: "wrong password" }}
      expect(response).to have_http_status(401)
    end
  end
end
