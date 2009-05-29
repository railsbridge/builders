require "RedCloth"

module UsersHelper
  
  def safe_textilize(text)
    if text.respond_to?(:to_s)
      markup = RedCloth.new(text.to_s)
      markup.sanitize_html = true
      markup.to_html
    end
  end

end
