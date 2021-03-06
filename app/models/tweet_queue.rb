class TweetQueue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_and_belongs_to_many :tweets

  def TweetQueue.timeline(user, connection)
     tweets = connection.home_timeline
  end

  def TweetQueue.build(user, connection)
    require 'json'

    # ensure user has a tweet queue
    if !user.tweet_queue
      tq = TweetQueue.create!
      user.tweet_queue = tq
      user.tweet_queue.save!
      user.save!
    end

    # get timeline from Twitter API
    tweets = TwitterCache.home_timeline(connection)

    # save each tweet and if doesn't yet exist, add to queue
    tweets.each do |tweet|
      new_tweet = Tweet.new 
      new_tweet.tweet_id = tweet['id']
      new_tweet.payload = JSON.parse(tweet.to_json)
      if new_tweet.save
        # add to tweet queue
        user.tweet_queue.tweets << new_tweet
        user.tweet_queue.save!
        user.save!
      end
    end
  end

  def pop(tweet_id, value) # pop a queue by giving it a point value from the user
    tweet = self.tweets.find(tweet_id)

    if tweet
      p = Point.new
      p.value = value
      p.user = self.user
      p.tweet = tweet
      if p.save!
        self.tweets.delete(tweet)
      end
    end
  end
end