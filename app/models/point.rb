class Point
  include Mongoid::Document

  field :value, type: Integer

  has_one :tweet
  belongs_to :user
end
