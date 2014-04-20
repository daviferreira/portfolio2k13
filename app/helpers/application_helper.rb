module ApplicationHelper
    def current_locale
        I18n.locale if I18n.locale != I18n.default_locale
    end

    # http://stackoverflow.com/a/6925495
    # Strip all whitespace between the HTML tags in the passed block, and
    # on its start and end.
    def spaceless(&block)
      contents = capture(&block)

      # Note that string returned by +capture+ is implicitly HTML-safe,
      # and this mangling does not introduce unsafe changes, so I'm just
      # resetting the flag.
      contents.strip.gsub(/>\s+</, '><').html_safe
    end
end
