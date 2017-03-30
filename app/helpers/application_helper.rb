module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "The Photon Factory"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  #adds javascript include tags in head
	#dynamically determine javascript file for template
  def javascript(*files)
		content_for(:head) { javascript_include_tag(*files) }  
  end
end