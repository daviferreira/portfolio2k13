require 'spec_helper'

describe ApplicationHelper do
  describe "current_locale" do
    it "should return locale when different from default" do
      I18n.default_locale = "pt-BR"
      I18n.locale = "en"
      helper.current_locale.should == :en
    end
  end
end
