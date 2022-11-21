class Answer < ApplicationRecord
  belongs_to :question
  validates :name, presence: true, uniqueness: true
  validates :answer, presence: true
end
