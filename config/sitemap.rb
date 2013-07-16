SitemapGenerator::Sitemap.default_host = "http://www.daviferreira.com"

SitemapGenerator::Sitemap.create do

  # TODO:
  #   categories
  #   tags

  # pt-br
  pages_to_be_indexed = ['livro', 'decks', 'sobre']

  add open_source_path(:locale => nil)
  add posts_path(:locale => nil)
  add projects_path(:locale => nil)

  Post.published_local.where(:locale => 'pt-BR').each do |post|
    add post_path(post, :locale => nil),
        :lastmod => post.updated_at
  end

  Project.published
         .with_translations(I18n.default_locale)
         .each do |project|
    add project_path(project, :locale => nil),
        :lastmod => project.updated_at
  end

  pages_to_be_indexed.each do |slug|
    add page_path(Page.find_using_slug(slug), :locale => nil)
  end


  # en
  I18n.locale = :en
  pages_to_be_indexed = ['book', 'presentations', 'about']

  add localized_root_path(:locale => I18n.locale)
  add open_source_path(:locale => I18n.locale)
  add posts_path(:locale => I18n.locale)
  add projects_path(:locale => I18n.locale)

  Post.published_local.where(:locale => 'en').each do |post|
    add post_path(post, :locale => I18n.locale),
        :lastmod => post.updated_at
  end

  Project.published
         .with_translations(I18n.locale)
         .each do |project|
    add project_path(project, :locale => I18n.locale),
        :lastmod => project.updated_at
  end

  pages_to_be_indexed.each do |slug|
    add page_path(Page.find_using_slug(slug), :locale => I18n.locale)
  end

end
