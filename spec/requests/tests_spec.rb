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
        expect(response.body).to include("Test created successfully")
      end
    end

    describe "Update a test" do
      it "updates a test" do
        test = create(:test)
        put "/api/tests/#{test.id}", params: { test: { name: 'Test 136633', description: 'MyText' } }.to_json, headers: @headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Test updated successfully")
      end
    end

    describe "Delete a test" do
      it "deletes a test" do
        test = create(:test)
        delete "/api/tests/#{test.id}", headers: @headers
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Test deleted successfully")
      end
    end
  end

  context "when as a student" do
    before(:each) do
      @user = sign_in_student
      # sign_in @user
      @headers = {
        'Content-Type': 'application/json',
        Accept: 'application/json',
        Authorization: "Bearer #{@user['token']}",
        uid: @user['email']
      }
    end

    describe "Get all tests" do
      it "gets all tests" do
        get '/api/tests', headers: @headers
        expect(response).to have_http_status(:ok)
      end
    end

    describe "Get a test" do
      it "gets a test" do
        test = create(:test)
        get "/api/tests/#{test.id}", headers: @headers
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
