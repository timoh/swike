class Tweet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :payload, type: Hash
  field :tweet_id, type: String
  
  has_and_belongs_to_many :tweet_queues
  has_many :points

  validates_presence_of :tweet_id
  validates_uniqueness_of :tweet_id
end
