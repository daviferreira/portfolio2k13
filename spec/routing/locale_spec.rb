require 'spec_helper'

describe "Locale routing" do

  describe "Projects" do
    it "should route to project with english locale" do
      { :get => "/en/projects/test-project" }.
          should route_to(
          :locale => "en",
          :controller => "projects",
          :action => "show",
          :id => "test-project"
        )
    end

    it "should not accept an invalid locale" do
      { :get => "/fr/projects/test-project" }.should_not be_routable
    end

    it "should accept no locale" do
      { :get => "/projects/test-project" }.
          should route_to(
          :controller => "projects",
          :action => "show",
          :id => "test-project"
        )
    end
  end
end
