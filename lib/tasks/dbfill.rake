namespace :db do
  require 'faker'

  task fill: :environment do
    # Delete all previous entries
    puts '=== Deleting all previous users ==='
    User.all.delete_all
    Event.all.delete_all
    Invite.all.delete_all
    Opportunity.all.delete_all

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
    50.times do |x|
      puts "=== Creating User ##{x + 1} ==="
      role = (x % 10).zero? ? 'editor' : 'user'

      User.create!(
        email: Faker::Internet.unique.email,
        first_name: Faker::Name.unique.first_name,
        last_name: Faker::Name.unique.last_name,
        password: 'password',
        # password_comfirmation: 'password',
        role: role
      )
    end

    # for associations
    userid = User.first.id

    # Create events
    50.times do |x|
      puts "=== Creating Event ##{x + 1} ==="
      # role = (x % 10).zero? ? 'editor' : 'user'

      Event.create!(
        content: Faker::Hipster.paragraph(5),
        location: Faker::Address.full_address,
        signup_link: Faker::Internet.url,
        time: Faker::Time.forward(x, :afternoon),
        title: Faker::ChuckNorris.fact,
        user_id: userid
      )
    end

    # Create opportunities
    50.times do |x|
      puts "=== Creating Opportunity ##{x + 1} ==="
      # role = (x % 10).zero? ? 'editor' : 'user'

      Opportunity.create!(
        content: Faker::Hipster.paragraph(5),
        company: Faker::Company.name,
        contact: Faker::Name.name,
        email: Faker::Internet.email,
        good_until: Faker::Time.forward(x * 20, :afternoon),
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
  end
end
