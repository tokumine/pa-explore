desc "generate test users"
task :fake_users => :environment do
  50.times do 
    User.create :username => Faker::Internet.user_name, :email => Faker::Internet.email, :password => 'xxxxxx', :password_confirmation => 'xxxxxx', :meters_explored => rand(30000)
  end  
end
