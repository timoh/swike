class HomeController < ApplicationController
  def index
  end

  def tweets_to_json
    if current_user && session[:user_key] && session[:user_secret]
      render json: TweetQueue.timeline(current_user, Connection.up(session[:user_key], session[:user_secret])).to_json
    else
      render json: 'Sign in first!'
    end
  end
end
