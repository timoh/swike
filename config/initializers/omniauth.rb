Rails.application.config.middleware.use OmniAuth::Builder do

  if !Rails.application.config.omniauth_key || !Rails.application.config.omniauth_secret
    raise 'missing Omniauth key & secret variables for Twitter .. setup as its own initializer and remember to gitignore!'
  end

  provider :twitter, Rails.application.config.omniauth_key, Rails.application.config.omniauth_secret
end