 FactoryBot.define do
  factory :invite do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    code { Faker::Crypto.unique.md5 }
    role { "user" }
    expiry { Time.now + 3600 }
    association :user, factory: :user, role: "editor"
  end

  factory :user, class: User do
    first_name { Faker::Name.unique.first_name }
    last_name  { Faker::Name.unique.last_name }
    role  { "user" }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(10, 20) }
    password_confirmation { password }
    password_digest { User.digest(password) }
  end

  factory :editor, parent: :user do
    role  { "editor" }
  end

  factory :admin, parent: :user do
    role  { "admin" }
  end

  factory :opportunity, class: Opportunity do
    user
    title { Faker::Job.title }
    company { Faker::Company.unique.name }
    contact { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    paid_position { true }
    content { Faker::Restaurant.review }
    good_until { Time.now + 3600 }
  end

  factory :event, class: Event do
    user
    title { Faker::Restaurant.unique.name }
    time { Time.now + 3600 }
    location { Faker::Address.full_address }
    signup_link { Faker::Internet.url }
    content { Faker::Restaurant.review }
  end
end