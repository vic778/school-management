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
end
