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
    role

    to_create do |instance|
      instance.id = User.find_or_create_by(email: instance.email).id
      instance.reload
    end
  end

  FactoryBot.define do
    factory :test do
      sequence :name do |n|
        "Test #{n}"
      end
      description { "MyText" }
    end
  end

  FactoryBot.define do
    factory :question do
      sequence :title do |n|
        "Question #{n}"
      end
      description { "MyText" }
      association :test, factory: :test
    end
    trait :teacher do
      association :role, factory: :role, name: 'teacher'
    end
  end

  FactoryBot.define do
    factory :answer do
      sequence :name do |n|
        "Answer #{n}"
      end
      answer { false }
      association :question, factory: :question
    end

    trait :teacher do
      association :role, factory: :role, name: 'teacher'
    end
  end
end
