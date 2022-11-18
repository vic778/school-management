class Role < ApplicationRecord
  enum name: {
    student: 0,
    teacher: 1
  }

  validates :name, presence: true, uniqueness: true
end
