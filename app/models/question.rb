class Question < ApplicationRecord
  belongs_to :test
  has_many :answers
  has_one :correct_answer, -> { where answer: true }, class_name: 'Answer'
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
end
