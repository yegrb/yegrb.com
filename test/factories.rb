 FactoryBot.define do
  factory :invite do
    name { "MyString" }
    email { "MyString" }
    code { "MyString" }
    expiry { "2019-03-22 14:19:19" }
    user_id { 1 }
  end

  factory :user, class: User do
    first_name { "Awesome" }
    last_name  { "User" }
    role  { "user" }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password_digest { User.digest('password') }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :editor, class: User do
    first_name { "Awesome" }
    last_name  { "Editor" }
    role  { "editor" }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password_digest { User.digest('password') }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :admin, class: User do
    first_name { "Awesome" }
    last_name  { "Admin" }
    role  { "admin" }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password_digest { User.digest('password') }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :opportunity, class: Opportunity do
    user
    title { "Awesome" }
    company { "Awesome" }
    contact { "Awesome" }
    email { "example@email.com" }
    paid_position { true }
    content { "Awesome" }
    good_until { Time.now + 3600 }
  end

  factory :event, class: Event do
    user
    title { "Awesome" }
    time { Time.now + 3600 }
    location { "Awesome" }
    signup_link { "Awesome" }
    content { "example@email.com" }
  end
end