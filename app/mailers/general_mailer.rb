class GeneralMailer < ActionMailer::Base
  default :from => "webadmin@bettersense.com"
  default :to => BetterSenseDemo::APP_CONFIG["web_contact_email_address"]
  
  def website_contact_form(contact_info)
    @contact_info = contact_info #For use in view
    mail(:from => contact_info["owner_email"], :subject => "New contact from web form.") #This gets returned as an object
  end
  
end
