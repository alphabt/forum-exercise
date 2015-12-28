namespace :dev do
  task :fake => :environment do
    puts "Creating fake data..."

    # Clean db
    Topic.destroy_all

    # Fake data
    50.times do |i|
      title = Faker::Hipster.sentence
      content = Faker::Hipster.paragraph(3, true, 5)
      Topic.create!(:title => title, :content => content)
    end
  end
end
