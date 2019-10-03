namespace :db do
  require 'faker'

  task fill: :environment do
    # Delete all previous entries
    puts '=== Deleting all previous users ==='
    User.all.delete_all
    Event.all.delete_all
    Invite.all.delete_all
    Opportunity.all.delete_all
    Video.all.delete_all

    # Create admin
    puts "=== Creating Admin account: #{ENV['ADMIN_EMAIL']} ==="
    User.create!(
      email: ENV['ADMIN_EMAIL'],
      password: ENV['ADMIN_PASS'],
      password_confirmation: ENV['ADMIN_PASS'],
      role: 'admin',
      first_name: ENV['ADMIN_FIRST'],
      last_name: ENV['ADMIN_LAST']
    )

    # Create users
    10.times do |x|
      puts "=== Creating User ##{x + 1} ==="
      role = (x % 10).zero? ? 'editor' : 'user'

      User.create!(
        email: Faker::Internet.unique.email,
        first_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.last_name,
        password: 'password',
        password_confirmation: 'password',
        role: role
      )
    end

    # for associations
    userid = User.first.id

    # Create events

    puts '=== Creating Actual Events ==='
    Event.create!(
      content: Faker::Hipster.paragraph(sentence_count: 5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzcbhb/',
      title: 'January Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(sentence_count: 5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzdbdb/',
      title: 'February Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(sentence_count: 5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzfbdb/',
      title: 'March Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(sentence_count: 5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzgbjb/',
      title: 'April Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(sentence_count: 5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzhbgb/',
      title: 'May Meetup',
      user_id: userid
    )

    # Create opportunities
    50.times do |x|
      puts "=== Creating Opportunity ##{x + 1} ==="
      # role = (x % 10).zero? ? 'editor' : 'user'

      Opportunity.create!(
        content: Faker::Hipster.paragraph(sentence_count: 5),
        company: Faker::Company.name,
        contact: Faker::Name.name,
        email: Faker::Internet.email,
        good_until: Faker::Time.forward(days: x, period: :afternoon),
        paid_position: true,
        title: Faker::ChuckNorris.fact,
        user_id: userid
      )
    end

    # Create invites
    15.times do |x|
      puts "=== Creating Invite ##{x + 1} ==="
      role = (x % 5).zero? ? 'editor' : 'user'

      Invite.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        role: role,
        user_id: userid
      )
    end

    # Create Videos
    puts '=== Creating Actual Videos ==='
    Video.create!(
      video_url: 'https://www.youtube.com/watch?v=P2uXoke8Cg0&list=PLwNT4e8fY2ZhehBUDoxvHkc9osAy2YLvc&index=2&t=4s',
      slides_url: 'https://goo.gl/St24uD',
      title: 'There to Here: Recent Evolutions of Ruby',
      speaker: 'Ben Zittlau',
      summary: 'The what and the why',
      runtime: 33,
      user_id: userid,
      event_id: Event.find_by(title: 'January Meetup').id,
      recorded_at: 'Sat, 05 Jan 2019 12:11:00 UTC +00:00'
    )
    Video.create!(
      video_url: 'https://www.youtube.com/watch?v=ejw805XGaAQ',
      title: 'The Nimble Programmer Bootcamp',
      speaker: 'Doug Kaweski',
      speaker_url: 'https://nimbleprogrammer.com/',
      summary: 'A Ruby on Rails Bootcamp for the Alberta Market',
      runtime: 40,
      user_id: userid,
      event_id: Event.find_by(title: 'January Meetup').id,
      recorded_at: 'Sat, 05 Jan 2019 12:11:00 UTC +00:00'
    )
    Video.create!(
      video_url: 'https://www.youtube.com/watch?v=yFKT4usgZxQ',
      title: 'Idiomatic Ruby + Idiomatic Rails',
      speaker: 'Donald Fenniak',
      summary: 'When in Ruby, do as the Rubyists do',
      runtime: 38,
      user_id: userid,
      event_id: Event.find_by(title: 'February Meetup').id,
      recorded_at: 'Sat, 06 Feb 2019 12:11:00 UTC +00:00'
    )
    Video.create!(
      video_url: 'https://www.youtube.com/watch?v=xJsJ4paVVA8',
      slides_url: 'https://docs.google.com/presentation/d/1eag2L_QUMy3uiPpeQZN6zvy-prCwbHfVR1o0g_GaOFY/edit?usp=sharing',
      speaker_url: 'https://www.alanvardy.com',
      title: 'Deploying a Rails App with Dokku and Digital Ocean',
      speaker: 'Alan Vardy',
      summary: 'Live deployment of a Rails app to a $5 Digital Ocean droplet using Dokku, a self-hosted Heroku alternative',
      runtime: 33,
      user_id: userid,
      event_id: Event.find_by(title: 'February Meetup').id,
      recorded_at: 'Sat, 06 Feb 2019 12:11:00 UTC +00:00'
    )
    Video.create!(
      video_url: 'https://www.youtube.com/watch?v=1fHS4w5eTLw&list=PLwNT4e8fY2ZhehBUDoxvHkc9osAy2YLvc&index=3',
      title: 'Mass Production with FactoryBot',
      speaker: 'Susan Wright',
      summary: 'Creating test objects using FactoryBot and Rspec',
      runtime: 35,
      user_id: userid,
      event_id: Event.find_by(title: 'April Meetup').id,
      recorded_at: 'Sat, 06 April 2019 12:11:00 UTC +00:00'
    )
  end
end
