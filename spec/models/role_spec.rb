require 'rails_helper'

RSpec.describe Role, type: :model do
  it { is_expected.to have_many(:users) }
  it { is_expected.to validate_presence_of(:name) }

  describe 'enum' do
    it { is_expected.to define_enum_for(:name).with_values(student: 0, teacher: 1) }
  end

  describe 'after_initialize' do
    it 'sets default role to student' do
      role = FactoryBot.build(:role)
      expect(role.name) == 'student'
    end
  end

  describe 'teacher?' do
    it 'returns true if role is teacher' do
      role = FactoryBot.build(:role, :teacher)
      expect(role.teacher?).to be true
    end

    it 'returns false if role is not teacher' do
      role = FactoryBot.build(:role, :student)
      expect(role.teacher?).to be false
    end
  end
end
