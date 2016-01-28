module ApplicationHelper
  def page_title
    title = "寿司クイック"
    title = @page_title + " - " + title if @page_title
    title
  end

  def menu_link_to(text, path)
    link_to_unless_current(text, path) { content_tag(:span, text) }
  end

	def merchandise_image_tag(merchandise, options ={})
		path = image_merchandise_path(merchandise, format: merchandise.extension)
		link_to(image_tag(path, {alt: merchandise.merchandise_name}.merge(options)), merchandise)
	end

end
