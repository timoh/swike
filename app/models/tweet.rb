class Tweet
  include Mongoid::Document

  field :payload, type: Hash
  field :tweet_id, type: Hash
  
  has_and_belongs_to_many :tweet_queues

  validates_presence_of :tweet_id
  validates_uniqueness_of :tweet_id
end
