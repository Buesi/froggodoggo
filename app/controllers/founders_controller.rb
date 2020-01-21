class FoundersController < ApplicationController
  before_action :logged_in_using_omniauth?
  before_action :founder_only, except: [:index_anonymous, :show_anonymous, :show, :new_admin, :create_admin]
  before_action :admin_only, only: [:new_admin, :create_admin, :review_admin, :review_admin_accepted]

  def new_admin #make admin only
  end

  def create_admin #make admin only
    user = User.new(:name => params[:user][:name], :surname => params[:user][:surname], :email => params[:user][:email], :auth0_id => params[:user][:auth0_id], :profile_picture_id => params[:user][:profile_picture_id])
    user.save

    founder = Founder.new(:user_id => user.id)
    founder.save

    tech_breakdown = TechBreakdown.new(:founder_id => founder.id)
    tech_breakdown.save
    tech_breakdown = TechBreakdown.new(:founder_id => founder.id)
    tech_breakdown.save
    tech_breakdown = TechBreakdown.new(:founder_id => founder.id)
    tech_breakdown.save
    tech_breakdown = TechBreakdown.new(:founder_id => founder.id)
    tech_breakdown.save
    tech_breakdown = TechBreakdown.new(:founder_id => founder.id)
    tech_breakdown.save

    redirect_to "/founders/new_admin"
  end

  def review_admin
    @unreviewed_entries = UnreviewedFounderEntry.where(review_status: 0).all
  end

  def review_admin_accepted
    url = Rack::Utils.parse_query URI(request.original_url).query 
    reviewed_founder_id = url["reviewed_founder_id"]
    founder = Founder.where(id: reviewed_founder_id).last
    unreviewed_founder_entries = UnreviewedFounderEntry.where(review_status: 0, founder_id: reviewed_founder_id).last
   
    if unreviewed_founder_entries.company_description.present?
       founder.company_description = unreviewed_founder_entries.company_description 
    end
    if unreviewed_founder_entries.done_so_far.present?
       founder.done_so_far = unreviewed_founder_entries.done_so_far 
    end
    if unreviewed_founder_entries.cool_work.present?
       founder.cool_work = unreviewed_founder_entries.cool_work 
    end
    if unreviewed_founder_entries.impressive_build.present?
       founder.impressive_build = unreviewed_founder_entries.impressive_build 
    end
    if unreviewed_founder_entries.important_in_5years.present?
       founder.important_in_5years = unreviewed_founder_entries.important_in_5years 
    end

    founder.save
    unreviewed_founder_entries.review_status = "accepted"
    unreviewed_founder_entries.save

    redirect_to "/founders/review_admin"

  end

  def index_anonymous
    url = Rack::Utils.parse_query URI(request.original_url).query 
    sorter = url["sort"]
    @direc = url["direc"]
    public_founders = Founder.where("profile_public = ?", true).all

    case sorter
    when "specialisation"
      @founders = public_founders.order("specialisation #{@direc}").all
        if @direc == 'ASC'
          @direc = 'DESC'
        elsif @direc == 'DESC'
          @direc = 'ASC'
        end
    when "years_in_software"
      @founders = public_founders.order("years_in_software #{@direc}").all
        if @direc == 'ASC'
          @direc = 'DESC'
        elsif @direc == 'DESC'
          @direc = 'ASC'
        end
    when "days_per_week"
      @founders = public_founders.order("days_per_week #{@direc}").all
        if @direc == 'ASC'     
          @direc = 'DESC'      
        elsif @direc == 'DESC'
          @direc = 'ASC'
        end    
    when "duration"
      @founders = public_founders.order("duration #{@direc}").all
        if @direc == 'ASC'     
          @direc = 'DESC'      
        elsif @direc == 'DESC'
          @direc = 'ASC'
        end   
    else
      @founders = public_founders.all 
      @direc = 'ASC'
    end
  end

  def home
    @founder = Founder.find(@founder_id)
 
    @user = User.where("id = ?", @founder.user_id).last
    @profile_pic = ProfilePicture.where("id = ?", @user.profile_picture_id).last

  end

  def show
    @founder = Founder.find(params[:id])

    @user = User.where("id = ?", @founder.user_id).last
    @profile_pic = ProfilePicture.where("id = ?", @user.profile_picture_id).last

    @contact = Contact.where("founder_id = ? AND company_id = ?", @founder.id, @company_id).first

    if !@contact || !@contact.paid || @contact.hire_status == 'declined'
      redirect_to "/search/founders/#{@founder.id}"
    end
  end  

  def show_anonymous
    @founder = Founder.find(params[:id])

    @user = User.where("id = ?", @founder.user_id).last
    @profile_pic = ProfilePicture.where("id = ?", @user.profile_picture_id).last

    @contact = Contact.where("founder_id = ? AND company_id = ?", @founder.id, @company_id).first

    if @contact.present? && @contact.paid && @contact.hire_status != 'declined'
      redirect_to "/founders/#{@founder.id}/connected"
    end 
  end   

  def show_profile
    @founder = Founder.find(@founder_id)
    @user = User.where(id: @founder.user_id).last
    @profile_pic = ProfilePicture.where(id: @user.profile_picture_id).last
    @entry = UnreviewedFounderEntry.where(founder_id: @founder_id, review_status: 0).last
    tech = TechBreakdown.where(founder_id: @founder_id).all #sort by id!!!

    tech_breakdown_present = false
    tech.each do |t|
      if t.name.present? and t.proficiency.present? and t.experience.present?
        tech_breakdown_present = true
        break
      end
    end 

    if @founder.user.name.present? and @founder.user.surname.present? and @founder.user.email.present? and @founder.company.present? and @founder.website.present? and @founder.github.present? and @founder.specialisation_formatted.present? and @founder.years_in_software.present? and @founder.days_per_week_formatted.present? and @founder.duration_formatted.present? and @founder.company_description.present? and @founder.done_so_far.present? and @founder.cool_work.present? and @founder.impressive_build.present? and @founder.important_in_5years.present? and tech_breakdown_present

      @publishable = true
    else
      @publishable = false
    end

    unless @entry.nil?
      if @entry.company_description.present?
        @founder.company_description = @entry.company_description 
      end
      if @entry.done_so_far.present?
        @founder.done_so_far = @entry.done_so_far 
      end
      if @entry.cool_work.present?
        @founder.cool_work = @entry.cool_work 
      end
      if @entry.impressive_build.present?
        @founder.impressive_build = @entry.impressive_build 
      end
      if @entry.important_in_5years.present?
        @founder.important_in_5years = @entry.important_in_5years 
      end     
    end
  end

  def company_contacts
    @founder = Founder.find(@founder_id)

    @all_contacts = Contact.where("founder_id = ? AND paid = ?", @founder_id, true).all
  end

  def edit
    @founder = Founder.find(@founder_id)
    @entry = UnreviewedFounderEntry.where("founder_id = ? AND review_status = ?" , @founder_id, 0).last

    unless @entry.nil?
      if @entry.company_description.present? #or use !@entry.company_description.nil? but then if founder just enters a space, it wouldn't show
        @founder.company_description = @entry.company_description 
      end
      if @entry.done_so_far.present?
        @founder.done_so_far = @entry.done_so_far 
      end
      if @entry.cool_work.present?
        @founder.cool_work = @entry.cool_work 
      end
      if @entry.impressive_build.present?
        @founder.impressive_build = @entry.impressive_build 
      end
      if @entry.important_in_5years.present?
        @founder.important_in_5years = @entry.important_in_5years 
      end
    end

  end

  def update
    @founder = Founder.find(@founder_id)

     unless @founder.company_description == founder_params[:company_description] && @founder.done_so_far == founder_params[:done_so_far] && @founder.cool_work == founder_params[:cool_work] && @founder.impressive_build == founder_params[:impressive_build] && @founder.important_in_5years == founder_params[:important_in_5years] 

      @entry = UnreviewedFounderEntry.where("founder_id = ? AND review_status = ?" , @founder_id, 0).last

      if !@entry.present?
        @entry = UnreviewedFounderEntry.new  

        @entry.founder_id = @founder_id
        
        if @founder.company_description != founder_params[:company_description]
           @entry.company_description = founder_params[:company_description]   
        end
        if @founder.done_so_far != founder_params[:done_so_far]
           @entry.done_so_far = founder_params[:done_so_far]
        end
        if @founder.cool_work != founder_params[:cool_work]
           @entry.cool_work = founder_params[:cool_work]
        end
        if @founder.impressive_build != founder_params[:impressive_build]
           @entry.impressive_build = founder_params[:impressive_build]
        end
        if @founder.important_in_5years != founder_params[:important_in_5years]
           @entry.important_in_5years = founder_params[:important_in_5years]
        end

        @entry.save

      else
        if @founder.company_description != founder_params[:company_description] && @entry.company_description != founder_params[:company_description]
          @entry.company_description = founder_params[:company_description]
        end 
        if @founder.done_so_far != founder_params[:done_so_far] && @entry.done_so_far != founder_params[:done_so_far]
          @entry.done_so_far = founder_params[:done_so_far]
        end 
        if @founder.cool_work != founder_params[:cool_work] && @entry.cool_work != founder_params[:cool_work]
          @entry.cool_work = founder_params[:cool_work]
        end 
        if @founder.impressive_build != founder_params[:impressive_build] && @entry.impressive_build != founder_params[:impressive_build]
          @entry.impressive_build = founder_params[:impressive_build]
        end 
        if @founder.important_in_5years != founder_params[:important_in_5years] && @entry.important_in_5years != founder_params[:important_in_5years]
          @entry.important_in_5years = founder_params[:important_in_5years]
        end 

        @entry.save        
      end

    end

    # all anyways private columns (like user name) and the oney that show up in the anonymous profile but can't contain any secret information can be updated instantly
    if @founder.update(founder_params.slice(:days_per_week, :duration, :specialisation, :years_in_software, :qf_cat_dog, :qf_thrones_breaking, :qf_jungle, :qf_belt_susp, :company, :website, :github, :user_attributes, :tech_breakdowns_attributes))
      redirect_to "/founders/profile"
    else
      render 'edit'
    end

  end

  def publish
    @founder = Founder.find(@founder_id)

    if @founder.profile_public != true
      @founder.profile_public = true
    else
      @founder.profile_public = false
    end
    @founder.save
    redirect_to "/founders/profile"
  end

  def edit_profile_picture
    @founder = Founder.find(@founder_id)
    @profile_pictures = ProfilePicture.order("color DESC").all
  
    @user = User.where("id = ?", @founder.user_id).last
    @profile_pic = ProfilePicture.where("id = ?", @user.profile_picture_id).last

  end

  def update_profile_picture
    new_profile_picture_id = params[:profile_pic_id]
    founder_id = params[:founder_id]

    founder = Founder.find(founder_id)
    founder.user.profile_picture_id = new_profile_picture_id
    founder.save

    redirect_to "/founders/profile"

  end

  private
    def founder_params
      params.require(:founder).permit(:profile_pic, :days_per_week, :duration, :specialisation, :company_description, :done_so_far, :cool_work, :impressive_build, :important_in_5years, :years_in_software, :qf_cat_dog, :qf_thrones_breaking, :qf_jungle, :qf_belt_susp, :company, :website, :github, user_attributes: [:id, :name, :surname, :email], tech_breakdowns_attributes: [:id, :name, :proficiency, :experience]) #take :role out because no update if unreviewed?????
    end  
end
