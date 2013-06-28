module ProjectsHelper
  def show_tags_as_links(tags)
    html = ''
    tags.split(",").each do |tag|
      tag.strip!
      tag_url = projects_search_path(:locale => current_locale, :tag => tag)
      html << "<a href=\"#{tag_url}\">##{tag}</a>"
    end
    raw html
  end
end
