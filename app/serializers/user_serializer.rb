class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role
  belongs_to :role
end
