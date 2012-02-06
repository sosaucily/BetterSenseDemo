module ApplicationHelper
  
  # Get safe and compatible html code from a string
  # Params:
  # +text+:: The markdown string to convert to safe and compatible html
  # Return: HTML string representing the input markdown string
  def markdown(text)
    options = [:autolink, :no_intraemphasis]
    if (text.nil?) 
      return ""
    end

    #For some very basic safety, I will pull the words "script" and "table" out of this content
    clean_text = text.gsub("script","").gsub("table","")

  #  Redcarpet::Markdown.new(clean_text, *options).to_html.html_safe
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,:autolink => true, :no_inteaemphasis => true)
    markdown.render(clean_text).html_safe
  end
  
  # Convenience method for setting a page title
  # Sends page title to the 'yield' command in the application layout
  # Params:
  # +the_title+:: The desired page title
  def page_title(the_title)
    content_for(:title) { the_title }
  end
  
  def millis_to_HMS(millis)
    seconds = (millis || 0) / 1000
		hours = seconds.to_i / 3600
		seconds -= 3600*hours
		minutes = seconds / 60
		seconds -= 60*minutes
		return "%02d:%02d:%02d" % [hours, minutes, seconds]
	end
  
  def get_states
    return [ 	
  		['Select a State', 'None'],
  		['Alabama', 'AL'], 
  		['Alaska', 'AK'],
  		['Arizona', 'AZ'],
  		['Arkansas', 'AR'], 
  		['California', 'CA'], 
  		['Colorado', 'CO'], 
  		['Connecticut', 'CT'], 
  		['Delaware', 'DE'], 
  		['District Of Columbia', 'DC'], 
  		['Florida', 'FL'],
  		['Georgia', 'GA'],
  		['Hawaii', 'HI'], 
  		['Idaho', 'ID'], 
  		['Illinois', 'IL'], 
  		['Indiana', 'IN'], 
  		['Iowa', 'IA'], 
  		['Kansas', 'KS'], 
  		['Kentucky', 'KY'], 
  		['Louisiana', 'LA'], 
  		['Maine', 'ME'], 
  		['Maryland', 'MD'], 
  		['Massachusetts', 'MA'], 
  		['Michigan', 'MI'], 
  		['Minnesota', 'MN'],
  		['Mississippi', 'MS'], 
  		['Missouri', 'MO'], 
  		['Montana', 'MT'], 
  		['Nebraska', 'NE'], 
  		['Nevada', 'NV'], 
  		['New Hampshire', 'NH'], 
  		['New Jersey', 'NJ'], 
  		['New Mexico', 'NM'], 
  		['New York', 'NY'], 
  		['North Carolina', 'NC'], 
  		['North Dakota', 'ND'], 
  		['Ohio', 'OH'], 
  		['Oklahoma', 'OK'], 
  		['Oregon', 'OR'], 
  		['Pennsylvania', 'PA'], 
  		['Rhode Island', 'RI'], 
  		['South Carolina', 'SC'], 
  		['South Dakota', 'SD'], 
  		['Tennessee', 'TN'], 
  		['Texas', 'TX'], 
  		['Utah', 'UT'], 
  		['Vermont', 'VT'], 
  		['Virginia', 'VA'], 
  		['Washington', 'WA'], 
  		['West Virginia', 'WV'], 
  		['Wisconsin', 'WI'], 
  		['Wyoming', 'WY']]
	end
end
