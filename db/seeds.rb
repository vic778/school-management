# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create roles
role1 = Role.find_or_create_by!(name: "student")
role2 = Role.find_or_create_by!(name: "teacher")
# First Teacher account
User.create(name: "Teacher", email: "teacher@example.com", password: "12345678", password_confirmation: "12345678", role_id: role2.id, confirmed_at: Time.now)

# Faker create 10 test with 10 questions and 4 answers
10.times do
    test = Test.create(name: Faker::Educator.course_name, description: Faker::Lorem.paragraph)
    10.times do
        question = test.questions.create(title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph)
        4.times do
            question.answers.create(name: Faker::Lorem.sentence, answer: false)
        end
        question.answers.create(name: Faker::Lorem.sentence, answer: true)
    end
end