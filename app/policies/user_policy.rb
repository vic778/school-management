# class UserPolicy < ApplicationPolicy
#   attr_reader :user

#   def initialize(user)
#     @user = user
#     # @food = food
#   end

#   def create?
#     user.role.teacher?
#   end

#   def update?
#     user.role.teacher?
#   end

#   class Scope < Scope
#     # NOTE: Be explicit about which records you allow access to!
#     # def resolve
#     #   scope.all
#     # end
#   end
# end
