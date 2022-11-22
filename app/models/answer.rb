class Answer < ApplicationRecord
  belongs_to :question
  validates :name, presence: true, uniqueness: true
end
