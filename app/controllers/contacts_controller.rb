class ContactsController < ApplicationController

  def payment
    # puts "büsi"
    # puts request.original_url
    url = Rack::Utils.parse_query URI(request.original_url).query 
    # founder_id = url["founder_id"]
    # contact_id = url["contact_id"]
    # puts contact_id
    # puts founder_id

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'Contact',
        description: 'blabla',
        amount: 300,
        currency: 'usd',
        quantity: 1,
      }],
      success_url: "#{request.base_url}/founders/#{url["founder_id"]}?session_id={CHECKOUT_SESSION_ID}&contact_id=#{url["contact_id"]}", #change to dynamic
      cancel_url: "#{request.base_url}/search/founders/#{url["founder_id"]}", #change to dynamic
    )
  end

  def create
    founder_id = contact_params[:founder_id]

    company_id = 1 #change to dynamic after company login is done

    existing_contact = Contact.where("founder_id = ? AND company_id = ?", founder_id, company_id).first

    if !existing_contact
      contact = Contact.new(contact_params)
      contact.save
      redirect_to "/contacts/payment?founder_id=#{founder_id}&contact_id=#{contact.id}" #payment path is a page between the actueal founder page with the contact info and the anonymous founder page, it will inform the company about the charges and ask them to move on
    elsif !existing_contact.paid
      redirect_to "/contacts/payment?founder_id=#{founder_id}&contact_id=#{existing_contact.id}" #payment path is a page between the actueal founder page with the contact info and the anonymous founder page, it will inform the company about the charges and ask them to move on
    end   
  end

  private
    def contact_params
      params.require(:contact).permit(:company_id, :founder_id, :hired)
    end  
end
