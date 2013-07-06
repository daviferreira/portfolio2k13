SitemapGenerator::Sitemap.default_host = "http://www.daviferreira.com"

SitemapGenerator::Sitemap.create do

  # TODO:
  #   pages
  #   categories
  #   tags

  # pt-br
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


  # en
  I18n.locale = :en

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
end
