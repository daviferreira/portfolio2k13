module ProjectsHelper
  def show_tags_as_links(tags)
    html = ''
    tags.split(",").each do |tag|
      html << "<a href=\"#{projects_by_tag_path(tag.parameterize, :locale => current_locale)}\">##{tag}</a>"
    end
    raw html
  end
end
