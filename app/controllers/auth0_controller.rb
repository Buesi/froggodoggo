class Auth0Controller < ApplicationController
  before_action :logged_in_using_omniauth?, only: [:password_reset]

  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']

    # check if auth0_id exists in our databank
    # if not redirect to logout
    email = session[:userinfo][:info][:email]
    auth0_id = session[:userinfo][:uid]

    @user = User.where("auth0_id = ?", auth0_id).first # maybe add also e-mail condition
    
    if @user.present?
      session[:user_id] = @user.id
      @founder = Founder.where("user_id = ?", @user.id).first  
      if @founder.present?
        session[:founder_id] = @founder.id
        redirect_to "/founders/home"
      else
        @company = Company.where("user_id = ?", @user.id).first
        if @company.present?
          session[:company_id] = @company.id
          redirect_to "/companies/home" 
        else
          redirect_to "/logout"
        end 
      end  
    else
      redirect_to "/logout"
    end
  end

  def password_reset
    user = User.find(session[:user_id])

    if user.nil?
      return
    end

    auth0_id = user.auth0_id
    auth0_service = Auth0Service.new

    url = request.base_url
    if @founder_id.present?
      url += "/founders/home"
    elsif @company_id.present?
      url += "/companies/home"
    end

    result = auth0_service.password_change(url, auth0_id)
    if result.present?
      redirect_to result["ticket"]
    end

  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end
end
