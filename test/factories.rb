FactoryBot.define do
  factory :message do
  end

  factory :video do
    recorded_at { Time.now }
    slides_url { Faker::Internet.url }
    speaker { Faker::Name.name }
    speaker_url { Faker::Internet.url }
    summary { Faker::Restaurant.review }
    title { Faker::Restaurant.name }
    video_url { Faker::Internet.url }
    user
    event
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
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
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
