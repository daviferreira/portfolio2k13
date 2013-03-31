module ApplicationHelper
    def current_locale
        I18n.locale if I18n.locale != I18n.default_locale
    end
end
