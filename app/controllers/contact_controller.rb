class ContactController < ApplicationController
  #Get /
  def index
  end
  
  #POST /create
  #This means somebody filled out the contact form
  def create
    @contact_info = params
    GeneralMailer.delay.website_contact_form(@contact_info)
    flash[:notice] = 'Thank you for your inquery.  We\'ll be in touch with you shortly.'
    redirect_to "/"
  end

end
