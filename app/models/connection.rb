class Connection
  include Mongoid::Document

  def Connection.up(key, secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "ME6ruUpP707ZgN0wwISiGIIz2"
      config.consumer_secret     = "KCvlKrJ4wNRVKB3UToCkvmoeHIPeUn8MxI1QRv9lcgfr24EJrv"
      config.access_token        = key
      config.access_token_secret = secret
    end

    return client
  end

end
