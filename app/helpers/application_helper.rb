module ApplicationHelper
  def markdown(text)
    options = [:hard_wrap, :autolink, :no_intraemphasis]
    #$ad_markdown ||= Markdown.new(*options)
    #$ad_markdown.render(text)
    #For some minor safety, I will pull the word "script" out of this content
    if (text.nil?) 
      return ""
    end
    clean_text = text.gsub("script","").gsub("table","")
    Redcarpet.new(clean_text, *options).to_html.html_safe
  end
end
