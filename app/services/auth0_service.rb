require 'auth0'

class Auth0Service
  def initialize
    @auth0_client ||= Auth0Client.new(
      client_id: ENV['AUTH0_RUBY_CLIENT_ID'],
      client_secret: ENV['AUTH0_RUBY_CLIENT_SECRET'],
      domain: ENV['AUTH0_RUBY_DOMAIN'],
      api_version: 2,
      timeout: 15 # optional, defaults to 10
    )
  end

  def password_change(result_url, user_id)
    @auth0_client.post_password_change(result_url: result_url, user_id: user_id)

  rescue => ex

  end
end