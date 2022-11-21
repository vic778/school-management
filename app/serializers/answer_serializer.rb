class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :name, :correct
  # belongs_to :question
end
