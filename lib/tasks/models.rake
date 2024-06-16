
namespace :models do
  desc "Prints all users"
  task users: :environment do
    puts User.all.inspect
  end
end

