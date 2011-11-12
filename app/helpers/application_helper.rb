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

    Redcarpet.new(clean_text, *options).to_html.html_safe
  end
  
  # Convenience method for setting a page title
  # Sends page title to the 'yield' command in the application layout
  # Params:
  # +the_title+:: The desired page title
  def page_title(the_title)
    content_for(:title) { the_title }
  end
end
