namespace :dev do
  task :fake => :environment do
    puts "Creating fake data..."

    # Clean db
    Topic.destroy_all
    Comment.destroy_all
    User.destroy_all

    #Fake users
    users = []
    users << User.create!(:email => "user@email.com", :password => "password")

    10.times do
      users << User.create!(:email => Faker::Internet.email, :password => "password")
    end


    # Fake topics and comments
    50.times do |i|
      title = Faker::Hipster.sentence
      content = Faker::Hipster.paragraph(3, true, 5)
      t = Topic.create!(:title => title, :content => content, :category_id => rand(Category.count) + 1)
      rand(10).times do |j|
        t.comments.create!(:content => Faker::Hipster.paragraph)
      end
    end
  end
end
