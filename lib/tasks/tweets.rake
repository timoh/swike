namespace :tweets do
  desc "Purge all operative database collections including user collection"
  task purge_all: :environment do
    puts "Purging users: #{User.delete_all}"
    puts "Purging tweet queues: #{TweetQueue.delete_all}"
    puts "Purging points: #{Point.delete_all}"
    puts "Purging tweets: #{Tweet.delete_all}"
    puts "Purging API cache: #{TwitterCache.delete_all}"
  end
end
