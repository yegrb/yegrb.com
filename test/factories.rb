FactoryBot.define do
  factory :video do
    link { 'MyString' }
    title { 'MyString' }
    speaker { 'MyString' }
    user_id { 1 }
  end

  factory :invite do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    code { Faker::Crypto.unique.md5 }
    role { 'user' }
    expiry { Time.zone.now + 3600 }
    association :user, factory: :user, role: 'editor'
  end

  factory :expired_invite, parent: :invite do
    expiry { Time.zone.now - 10 }
  end

  factory :user, class: User do
    first_name { Faker::Name.unique.first_name }
    last_name  { Faker::Name.unique.last_name }
    role  { 'user' }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(10, 20) }
    password_confirmation { password }
    password_digest { User.digest(password) }
  end

  factory :editor, parent: :user do
    role  { 'editor' }
  end

  factory :admin, parent: :user do
    role  { 'admin' }
  end

  factory :opportunity, class: Opportunity do
    user
    title { Faker::Job.title }
    company { Faker::Company.unique.name }
    contact { Faker::Name.unique.name }
    email { Faker::Internet.email }
    paid_position { true }
    content { Faker::Restaurant.review }
    good_until { Time.zone.now + 90.days }
  end

  factory :event, class: Event do
    user
    title { Faker::Restaurant.unique.name }
    signup_link { 'https://www.meetup.com/startupedmonton/events/dgjjmqyzcbhb/' }
    content { Faker::Restaurant.review }
  end

  factory :future_event, class: Event do
    user
    title { Faker::Restaurant.unique.name }
    location { Faker::Address.full_address }
    time { Time.zone.now + 1.day }
    signup_link { 'https://www.meetup.com/startupedmonton/events/dgjjmqyzcbhb/' }
    content { Faker::Restaurant.review }
  end
end
