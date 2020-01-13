class ContactsController < ApplicationController

  def payment
    url = Rack::Utils.parse_query URI(request.original_url).query 
    @founder_id = url["founder_id"]

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Contact',
        description: 'blabla',
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

    existing_contact = Contact.where("founder_id = ? AND company_id = ?", founder_id, @company_id).first

    if !existing_contact
      contact = Contact.new(contact_params)
      contact.save
      redirect_to "/contacts/payment?founder_id=#{founder_id}&contact_id=#{contact.id}" 
    elsif !existing_contact.paid
      redirect_to "/contacts/payment?founder_id=#{founder_id}&contact_id=#{existing_contact.id}" 
    end   
  end

  private
    def contact_params
      params.require(:contact).permit(:company_id, :founder_id, :paid, :hired, :hire_status)
    end  
end
