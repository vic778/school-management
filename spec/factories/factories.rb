FactoryBot.define do
  factory :role do
    name { Role.names.keys.sample }

    to_create do |instance|
      instance.id = Role.find_or_create_by(name: instance.name).id
      instance.reload
    end
  end

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '12345678' }
    password_confirmation { '12345678' }
    association :role, factory: :role

    trait :teacher do
      association :role, factory: :role, name: 'teacher'
    end

    trait :student do
      association :role, factory: :role, name: 'student'
    end

    trait :with_confirmed_email do
      confirmed_at { Time.now }
    end
  end

  factory :test do
    sequence :name do |n|
      "Test #{n}"
    end
    description { "MyText" }
  end

  factory :question do
    sequence :title do |n|
      "Question #{n}"
    end
    description { "MyText" }
    association :test, factory: :test

    trait :teacher do
      association :role, factory: :role, name: 'teacher'
    end
  end

  factory :answer do
    sequence :name do |n|
      "Answer #{n}"
    end
    answer { false }
    association :question, factory: :question
  end
end
