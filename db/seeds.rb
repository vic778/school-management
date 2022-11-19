# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create roles
role = Role.find_or_create_by!(name: "teacher")
# First Teacher account
User.create(name: "Teacher", email: "teacher@example.com", password: "12345678", password_confirmation: "12345678", role_id: role.id, confirmed_at: Time.now)