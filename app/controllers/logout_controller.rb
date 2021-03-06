class LogoutController < ApplicationController

  def logout
    reset_session
    redirect_to logout_url.to_s
  end

  def logout_url
    domain = ENV['AUTH0_RUBY_DOMAIN']
    client_id = ENV['AUTH0_RUBY_CLIENT_ID']
    request_params = {
      returnTo: root_url + "login",
      client_id: client_id
    }

    URI::HTTPS.build(host: domain, path: '/v2/logout', query: to_query(request_params))
  end

  private

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{URI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end
  
end

