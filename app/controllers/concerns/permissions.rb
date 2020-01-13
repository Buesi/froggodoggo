
module Permissions
  extend ActiveSupport::Concern

  def founder_only
    redirect_to '/' unless session[:founder_id].present?
  end

  def company_only
    redirect_to '/' unless session[:company_id].present?
  end

  def admin_only
    redirect_to '/' unless session[:user_id] == ENV['ADMIN_USER_ID'].to_i
  end

end