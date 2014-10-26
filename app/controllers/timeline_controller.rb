class TimelineController < ApplicationController
  before_action :authenticate_user!
  before_action :build_queue

  def index 
      @tweets = current_user.tweet_queue
  end

  def show_first
      @first_tweet = current_user.tweet_queue.tweets.first
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

      if params[:redir]
        if params[:redir] == 'play'
          redirect_to '/play'
        end
      else
        redirect_to '/timeline'
      end
      
    else
      raise 'Problem with giving rating tweet'
    end
  end

  private
    def build_queue
      if current_user
        TweetQueue.build(current_user, Connection.up(session[:user_key], session[:user_secret]))
      end
    end
end
