class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid, type: String
  field :name, type: String

  has_one :tweet_queue, dependent: :delete
  has_many :points, dependent: :delete

   def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

  def favorite_authors(limit) # return a list of authors (twitter users) with the most likes 
    authors = Hash.new

    self.points.each do |point|
      unless point.tweet.payload["user"]["screen_name"]
        raise 'Tweet has no screen name'
      end

      if !authors || authors.size == 0
        handle = point.tweet.payload["user"]["screen_name"]
        authors[handle] = point.value
      else
        if authors[point.tweet.payload["user"]["screen_name"]]
          authors[point.tweet.payload["user"]["screen_name"]] = authors[point.tweet.payload["user"]["screen_name"]] + point.value
        else
          authors[point.tweet.payload["user"]["screen_name"]] = point.value
        end
      end
    end

    sorted_authors_array = authors.sort_by {|k, v| v}

    return sorted_authors_array.reverse.take(limit)
    # ==> [["authord", 745], ["authorc", 10], ["authora", 9]]
  end

  def worst_authors(limit) # return a list of authors (twitter users) with the least likes 
    authors = Hash.new

    self.points.each do |point|
      unless point.tweet.payload["user"]["screen_name"]
        raise 'Tweet has no screen name'
      end

      if !authors || authors.size == 0
        handle = point.tweet.payload["user"]["screen_name"]
        authors[handle] = point.value
      else
        if authors[point.tweet.payload["user"]["screen_name"]]
          authors[point.tweet.payload["user"]["screen_name"]] = authors[point.tweet.payload["user"]["screen_name"]] + point.value
        else
          authors[point.tweet.payload["user"]["screen_name"]] = point.value
        end
      end
    end

    sorted_authors_array = authors.sort_by {|k, v| v}

    return sorted_authors_array.take(limit)
    # ==> [["authora", 9], ["authorc", 10], ["authord", 745]]
  end
  
end
