class HomeController < ApplicationController
  def index

    if current_user && session[:user_key] && session[:user_secret]
      @tweets = TweetQueue.build(current_user, Connection.up(session[:user_key], session[:user_secret]))
    end

  end

  def tweets_to_json
    if current_user && session[:user_key] && session[:user_secret]
      render json: TweetQueue.build(current_user, Connection.up(session[:user_key], session[:user_secret])).to_json
    else
      render json: 'Sign in first!'
    end

  end
end
