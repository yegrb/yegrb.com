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
      content: Faker::Hipster.paragraph(5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzcbhb/',
      title: 'January Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzdbdb/',
      title: 'February Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzfbdb/',
      title: 'March Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzgbjb/',
      title: 'April Meetup',
      user_id: userid
    )
    Event.create!(
      content: Faker::Hipster.paragraph(5),
      url: 'https://www.meetup.com/startupedmonton/events/dgjjmqyzhbgb/',
      title: 'May Meetup',
      user_id: userid
    )

    # Create opportunities
    50.times do |x|
      puts "=== Creating Opportunity ##{x + 1} ==="
      # role = (x % 10).zero? ? 'editor' : 'user'

      Opportunity.create!(
        content: Faker::Hipster.paragraph(5),
        company: Faker::Company.name,
        contact: Faker::Name.name,
        email: Faker::Internet.email,
        good_until: Faker::Time.forward(x, :afternoon),
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
      video_url: 'https://www.youtube.com/watch?v=xJsJ4paVVA8',
      slides_url: 'https://docs.google.com/presentation/d/1eag2L_QUMy3uiPpeQZN6zvy-prCwbHfVR1o0g_GaOFY/edit?usp=sharing',
      speaker_url: 'https://www.alanvardy.com',
      title: 'Deploying a Rails App with Dokku and Digital Ocean',
      speaker: 'Alan Vardy',
      summary: Faker::Hipster.paragraph(2),
      runtime: 33,
      user_id: userid,
      event_id: Event.find_by(title: 'February Meetup').id,
      recorded_at: '2019-02-06'
    )
  end
end
