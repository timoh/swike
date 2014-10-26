class TwitterCache
  include Mongoid::Document
  include Mongoid::Timestamps

  field :cacheparams, type: Array
  field :output, type: Array

  def TwitterCache.home_timeline(connection) # return the tweets from the home timeline
    require 'json'
    params = Array.new
    params << JSON.parse(connection.to_json)
    tc = TwitterCache.where(cacheparams: params).first

    # the point of this is to do "eager loading" of the DB query, instead of storing the MOPED query
    if tc # if the request has been made earlier, just return it!

      puts '...'
      puts '...'
      puts '...'
      puts '-------------------- Avoided hitting the Twitter API!'
      puts '...'
      puts '...'
      puts '...'

      return tc.output
      
    else # otherwise, build request and store it
      tc = TwitterCache.new
      tc.cacheparams = params # store the input

      puts '...'
      puts '...'
      puts '...'
      puts '-------------------- Now hitting Twitter API with home_timeline request!'
      puts '...'
      puts '...'
      puts '...'

      twitter_query_result = connection.home_timeline # do the api query

      tweets = Array.new
      twitter_query_result.each do |tweet|
        tweets << JSON.parse(tweet.to_json)
      end
      tc.output = tweets # finally, save the result into 
      tc.save!

      return tc.output # return the tweets from the home timeline
    end
  end

end
