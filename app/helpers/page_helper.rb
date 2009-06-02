module PageHelper
  
  def link_to_static(page, description = nil)
    link_to(description.nil? ? page.to_s : description, site_path(:name => page.to_s))
  end

end
