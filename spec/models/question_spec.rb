require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'associations' do
    it { should belong_to(:test) }
    it { should have_many(:answers) }
    it { should have_one(:correct_answer) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe 'invalidations' do
    it 'is invalid without title' do
      question = FactoryBot.build(:question, title: nil)
      question.valid?
      expect(question.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without description' do
      question = FactoryBot.build(:question, description: nil)
      question.valid?
      expect(question.errors[:description]).to include("can't be blank")
    end
  end
end
