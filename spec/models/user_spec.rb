require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:role) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }

    describe 'after_initialize' do
      it 'sets default role to student' do
        user = FactoryBot.build(:user)
        expect(user.role.name) == 'student'
      end
    end

    describe 'teacher?' do
      it 'returns true if role is teacher' do
        user = FactoryBot.build(:user, :teacher)
        expect(user.role.teacher?).to be true
      end

      it 'returns false if role is not teacher' do
        user = FactoryBot.build(:user, :student)
        expect(user.role.teacher?).to be false
      end
    end

    describe 'update_role!' do
      it 'updates role_name' do
        user = FactoryBot.build(:user, :student)
        user.update_role!('teacher')
        expect(user.role.name).to eq 'teacher'
      end
    end

    describe 'requires_confirmation?' do
      it 'returns true if user is not confirmed' do
        user = FactoryBot.build(:user, :student)
        expect(user.requires_confirmation?).to be true
      end

      it 'returns false if user is confirmed' do
        user = FactoryBot.build(:user, :student)
        user.confirmed_at = Time.now
        expect(user.requires_confirmation?).to be false
      end
    end

    describe 'generate_jwt' do
      it 'returns a valid jwt' do
        user = FactoryBot.build(:user, :student)
        expect(user.generate_jwt).to be_truthy
      end
    end
  end
end
