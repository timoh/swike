class TimelineController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user
      TweetQueue.build(current_user, Connection.up(session[:user_key], session[:user_secret]))
      @tweets = current_user.tweet_queue
    end
  end

  def pop
    tweet_id = params[:tweet_id]
    value = params[:value]

    unless tweet_id && value
      raise 'Parameters were not set!'
    end

    if current_user && current_user.tweet_queue
      q = current_user.tweet_queue
      q.pop(tweet_id, value)
    else
      raise 'Problem with giving rating tweet'
    end
  end
end
