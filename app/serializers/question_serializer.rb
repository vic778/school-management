class QuestionSerializer < ActiveModel::Serializer
  attributes :id
  has_many :answers
end
