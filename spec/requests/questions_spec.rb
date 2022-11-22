require 'rails_helper'
require_relative '../features/sign_in_rspec'
RSpec.describe "Questions", type: :request do
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

    describe "Create a question" do
      it "creates a question with a correct answer" do
        test = create(:test)
        post "/api/tests/#{test.id}/questions", params: { title: "What is the capital of Nigeria", description: "Lorem ipsum", test_id: test.id }.to_json, headers: @headers
        response do
          data = JSON.parse(response.body)
          expect(data['success']).to eq(true)
          expect(data['message']).to eq("Question Created succefully")
          expect(data['question']['title']).to eq("What is the capital of Nigeria")
          expect(data['question']['description']).to eq("Lorem ipsum")
          expect(data['question']['test_id']).to eq(test.id)
        end
      end
    end

    describe "Gets a question" do
      it "Gets a question including answers" do
        test = create(:test)
        question = create(:question, test_id: test.id)
        answer = create(:answer, question_id: question.id)
        correct_answer = create(:answer, question_id: question.id, answer: true)
        get "/api/tests/#{test.id}/questions/#{question.id}", params: { title: "What is the capital of Nigeria", description: "Lorem ipsum", test_id: test.id }.to_json, headers: @headers
        response do
          data = JSON.parse(response.body)
          expect(data['success']).to eq(true)
          expect(data['message']).to eq("Question Updated succefully")
          expect(data['question']['title']).to eq("What is the capital of Nigeria")
          expect(data['question']['description']).to eq("Lorem ipsum")
          expect(data['question']['test_id']).to eq(test.id)
          expect(data['question']['answers'][0]['name']).to eq(answer.name)
          expect(data['question']['answers'][0]['answer']).to eq(answer.correct_answer)
        end
      end
    end

    describe "Delete a question" do
      it "Deletes a question with a correct answer" do
        test = create(:test)
        question = create(:question, test_id: test.id)
        delete "/api/tests/#{test.id}/questions/#{question.id}", headers: @headers
        response do
          data = JSON.parse(response.body)
          expect(data['success']).to eq(true)
          expect(data['message']).to eq("Question Deleted succefully")
        end
      end
    end
  end
end
