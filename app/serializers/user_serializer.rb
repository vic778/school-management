class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :created_at, :updated_at
  belongs_to :role
end
