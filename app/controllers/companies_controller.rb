class CompaniesController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :company_only, except: [:new_admin, :create_admin]
  before_action :admin_only, only: [:new_admin, :create_admin]

  def new_admin #make admin only
  end

  def create_admin #make admin only
    user = User.new(:name => params[:user][:name], :surname => params[:user][:surname], :email => params[:user][:email], :auth0_id => params[:user][:auth0_id], :profile_picture_id => params[:user][:profile_picture_id])
    user.save

    company = Company.new(:user_id => user.id)
    company.save

    redirect_to "/companies/new_admin"
  end
 
  def show    
    @company = Company.find(@company_id) 

    @user = User.where("id = ?", @company.user_id).last
    @profile_pic = ProfilePicture.where("id = ?", @user.profile_picture_id).last

  end  

  def home
    @company = Company.find(@company_id)

    @user = User.where("id = ?", @company.user_id).last
    @profile_pic = ProfilePicture.where("id = ?", @user.profile_picture_id).last

  end

  def contacted_founders
    @company = Company.find(@company_id)

    @all_contacts = Contact.where("company_id = ? AND paid = ? AND (hire_status = ? OR hire_status = ?)", @company.id, true, 0, 1).all
  end

  def edit
    @company = Company.find(@company_id)
  end

  def edit_profile_picture
    @company = Company.find(@company_id)
    @profile_pictures = ProfilePicture.order("color DESC").all
  
    @user = User.where("id = ?", @company.user_id).last
    @profile_pic = ProfilePicture.where("id = ?", @user.profile_picture_id).last

  end

  def update_profile_picture
    new_profile_picture_id = params[:profile_pic_id]
    company_id = params[:company_id]

    company = Company.find(company_id)
    company.user.profile_picture_id = new_profile_picture_id
    company.save

    redirect_to "/companies/profile"

  end

  def payment_overview
    @company = Company.find(@company_id)

    @all_contacts = Contact.where("company_id = ? AND paid = ?", @company_id, true).all
  end

  def mark_as_hired
    contact = Contact.where("company_id = ? AND paid = ? AND founder_id = ?", params[:id], true, params[:founder_id]).first
    contact.hire_status = 1
    contact.save
    redirect_to "/companies/contacted_founders"
  end

  def mark_as_not_hired
    contact = Contact.where("company_id = ? AND paid = ? AND founder_id = ?", params[:id], true, params[:founder_id]).first
    contact.hire_status = 2
    contact.save
    redirect_to "/companies/contacted_founders" 
  end

  def update
  @company = Company.find(@company_id)
 
    if @company.update(company_params)
      redirect_to "/companies/profile"
    else
      render 'edit'
    end
  end
   
  private
    def company_params
      params.require(:company).permit(:based_in, :company, :website, user_attributes: [:id, :name, :surname, :email])
    end  
end
