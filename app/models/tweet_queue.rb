class TweetQueue
  include Mongoid::Document

  belongs_to :user
  has_and_belongs_to_many :tweets


  def TweetQueue.build(user, connection)
    tweets = connection.home_timeline
  end
end
