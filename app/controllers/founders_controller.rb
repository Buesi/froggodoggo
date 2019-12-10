class FoundersController < ApplicationController

  def index
    @founders = Founder.all
  end

  def index_anonymous
    @founders = Founder.all 
  end

  def home
    @founder = Founder.find(params[:id])
  end

  def show
    @founder = Founder.find(params[:id])

    @company_id = 1 #has to be changed to dynamic once login is done!! current_user bla bla

    @contact = Contact.where("founder_id = ? AND company_id = ?", @founder.id, @company_id).first

    if !@contact
      redirect_to "/search/founders/#{@founder.id}"
    elsif !@contact.paid
      redirect_to "/search/founders/#{@founder.id}"     
    end
  end  

  def show_anonymous
    @founder = Founder.find(params[:id])

    @company_id = 1 #change to dynamic after company login is done

    @contact = Contact.where("founder_id = ? AND company_id = ?", @founder.id, @company_id).first

    if @contact && @contact.paid
      redirect_to "/founders/#{@founder.id}"
    end 
  end   

  def show_profile
    @founder = Founder.find(params[:id])
  end

  def payment_overview
    @founder = Founder.find(params[:id])
  end

  def payment_settings
    @founder = Founder.find(params[:id])
  end  

  def new
    @founder = Founder.new
    @founder.build_user
  end

  def edit
    @founder = Founder.find(params[:id])
  end

  def create
  @founder = Founder.new(founder_params)

  print founder_params
 
    if @founder.save
      redirect_to "/founders/#{@founder.id}/home"
    else
      render 'new'
    end
  end

  def update
  @founder = Founder.find(params[:id])
 
    if @founder.update(founder_params)
      redirect_to "/founders/#{@founder.id}/home"
    else
      render 'edit'
    end
  end

  # def destroy
  #   @founder = Founder.find(params[:id])
  #   @founder.destroy
 
  #   redirect_to "/new"
  # end
   
  private
    def founder_params
      params.require(:founder).permit(:company, :website, :github, user_attributes: [:name, :surname, :email, :password, :role])
    end  
end
