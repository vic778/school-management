require 'rails_helper'
require_relative '../features/sign_in_rspec'

RSpec.describe "Registrations", type: :request do
  context "when as a teacher" do
    before(:each) do
      @user = sign_in_teacher
      @headers = {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: "Bearer #{@user['token']}",
        uid: @user['email']
      }
    end

    it "creates a new user" do
      post '/api/users/register', params: { user: { email: 'test@gmail.com', name: 'hello', password: 'test123' }, confirmed_at: Time.now }.to_json, headers: @headers
      # binding.pry
      expect(response.body).to eq("Thank you for joining Oivan platform, please check your email and verify your account!")
    end
  end
end
