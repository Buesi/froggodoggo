class UsersController < ApplicationController
  before_action :logged_in_using_omniauth?
  
  def login
    if @user_id
      if @founder_id
        redirect_to "/founders/home"
      elsif @company_id
        redirect_to "/companies/home"
      end
    end
  end

  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   @user = User.find(params[:id])
 
  #   if @user.update(user_params)
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end
   
  # private
  #   def user_params
  #     params.require(:user).permit(:name, :surname, :email, :password, :role)
  #   end  
end
