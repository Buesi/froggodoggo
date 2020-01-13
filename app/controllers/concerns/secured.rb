module Secured
  extend ActiveSupport::Concern

  def logged_in_using_omniauth?
    if session[:userinfo].present?
      @user_id = session[:user_id]
      @founder_id = session[:founder_id]
      @company_id = session[:company_id]

    else
      redirect_to '/'
    end
  end
end