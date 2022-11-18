class Role < ApplicationRecord
    has_many :users

  enum name: {
    student: 0,
    teacher: 1
  }

  validates :name, presence: true, uniqueness: true
end
