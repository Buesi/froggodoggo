class StripeWebhooksController < ApplicationController

	skip_before_action :verify_authenticity_token

  def payment_successful
    # puts params

    if params["data"]["object"]["object"] == "checkout.session"
      success_url = params["data"]["object"]["success_url"]
      url = Rack::Utils.parse_query URI(success_url).query 
      contact_id = url["contact_id"]
      contact = Contact.find(contact_id)
      contact.paid = true
      contact.save
      # @contact.update_attribute(:paid, true) would maybe also work
      # do i need to define an else?
    end

  	head :ok
  end

end