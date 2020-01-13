class ApplicationController < ActionController::Base
  include Secured
  include Permissions
end
