class Test < ApplicationRecord
  has_many :questions
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
