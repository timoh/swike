class Point
  include Mongoid::Document
  include Mongoid::Timestamps

  field :value, type: Integer

  belongs_to :tweet
  belongs_to :user

  validates_presence_of :value
  validates_presence_of :tweet
  validates_presence_of :user
end
