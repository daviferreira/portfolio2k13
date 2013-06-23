module ProjectsHelper
  def show_tags_as_links(tags)
    html = ''
    tags.split(",").each do |tag|
      html << "<a href=\"#{projects_search_path(:locale => current_locale, :tag => tag)}\">##{tag}</a>"
    end
    raw html
  end
end
