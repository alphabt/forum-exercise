namespace :dev do
  task :fake => :environment do
    puts "Cleaning db..."

    # Clean db
    Topic.destroy_all
    Comment.destroy_all
    User.destroy_all

    puts "Creating fake data..."

    #Fake users
    users = []
    users << User.create!(
      :email => "user@email.com",
      :password => "password",
      :fullname => Faker::Name.name,
      :username => Faker::Internet.user_name)

    10.times do
      users << User.create!(
        :email => Faker::Internet.email,
        :password => "password",
        :fullname => Faker::Name.name,
        :username => Faker::Internet.user_name)
    end

    # Fake topics and comments
    50.times do |i|
      title = Faker::Hipster.sentence
      content = Faker::Hipster.paragraph(3, true, 5)
      t = Topic.create!(
        :title => title,
        :content => content,
        :category_id => rand(Category.count) + 1,
        :user => users.sample)

      rand(10).times do |j|
        t.comments.create!(
          :content => Faker::Hipster.paragraph,
          :user => users.sample)
      end
    end
  end
end
