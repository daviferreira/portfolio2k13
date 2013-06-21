module PagesHelper
    def render_page(slug)
        if I18n.locale != I18n.default_locale
          page = Page.find_by_cached_slug(slug)
        else
          page = Page.find_using_slug(slug)
        end
        if page
            raw page.body
        end
    end
end
