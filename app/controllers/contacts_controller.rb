class ContactsController < ApplicationController
  before_action :logged_in_using_omniauth?, only: [:create]

  def payment
    url = Rack::Utils.parse_query URI(request.original_url).query 
    @founder_id = url["founder_id"]

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Matching Fee',
        description: "We put the matching fee as a deposit on your credit card before showing you a founders contact details. We release the deposit if you don't end up hiring them. If you do hire them, we'll charge the matching fee.",
        amount: 30000,
        currency: 'usd',
        quantity: 1,
      }],
      payment_intent_data: {
        capture_method: 'manual',
      },
      success_url: "#{request.base_url}/founders/#{url["founder_id"]}/connected?session_id={CHECKOUT_SESSION_ID}&contact_id=#{url["contact_id"]}", #change to dynamic
      cancel_url: "#{request.base_url}/search/founders/#{url["founder_id"]}", #change to dynamic
    )
  end

  def create
    founder_id = contact_params[:founder_id]

    contact = Contact.where("founder_id = ? AND company_id = ?", founder_id, @company_id).first

    if !contact
      contact = Contact.create(contact_params)
    end

    redirect_to "/contacts/payment?founder_id=#{founder_id}&contact_id=#{contact.id}" 
 
  end

  private
    def contact_params
      params.require(:contact).permit(:company_id, :founder_id, :paid, :hired, :hire_status)
    end  
end
