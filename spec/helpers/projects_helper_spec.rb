require 'spec_helper'

describe ProjectsHelper do
  describe "showing tags as links" do
    it "should render tags as html links" do
      I18n.locale = :en
      html = ''
      html << "<a href=\"#{projects_search_path(:locale => I18n.locale, :tag => "javascript")}\">#javascript</a>"
      html << "<a href=\"#{projects_search_path(:locale => I18n.locale, :tag => "php")}\">#php</a>"
      html << "<a href=\"#{projects_search_path(:locale => I18n.locale, :tag => "css")}\">#css</a>"
      helper.show_tags_as_links("javascript,php, css").should == html
    end
  end
end
