require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'associations' do
    it { should belong_to(:question) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'invalidations' do
    it 'is invalid without question' do
      answer = FactoryBot.build(:answer, question: nil)
      answer.valid?
      expect(answer.errors[:question]).to include("must exist")
    end

    it 'is invalid without name' do
      answer = FactoryBot.build(:answer, name: nil)
      answer.valid?
      expect(answer.errors[:name]).to include("can't be blank")
    end
  end
end
