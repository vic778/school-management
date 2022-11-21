require 'rails_helper'
require_relative '../features/sign_in_rspec'

RSpec.describe "Tests", type: :request do
  context "when as a teacher" do
    before(:each) do
      @user = sign_in_teacher
      # sign_in @user
      @headers = {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: "Bearer #{@user['token']}",
        uid: @user['email']
      }
    end

    describe "Create a test" do
      it "creates a test" do
        # binding.pry
        post '/api/tests', params: { test: { name: 'Test 136633', description: 'MyText' } }.to_json, headers: @headers
        expect(response).to have_http_status(:created)
      end
    end
  end
end
