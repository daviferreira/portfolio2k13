require 'spec_helper'

describe Photo do
  before {
    project = FactoryGirl.create(:project)
    @photo = Photo.new(title: "Test Photo",
                       order: 1,
                       project_id: project.id)
  }

  subject { @photo }

  it { should respond_to(:title) }
  it { should respond_to(:order) }
  it { should respond_to(:project) }
  it { should respond_to(:file) }

  it { should be_valid }

  describe "when title is not present" do
    before { @photo.title = " " }
    it { should_not be_valid }
  end

  describe "when title is too long" do
    before { @photo.title = "a" * 141 }
    it { should_not be_valid }
  end

  describe "when order is invalid" do
    it "should not be valid when order is empty" do
      @photo.order = " "
      @photo.should_not be_valid
    end
    it "should not be valid when order is a string" do
      @photo.order = "ABC"
      @photo.should_not be_valid
    end
    it "should not be valid when order is float" do
      @photo.order = "123.3"
      @photo.should_not be_valid
    end
  end


  # TODO: validate project existance
  describe "when project is invalid" do
    before { @photo.project_id = "" }
    it { should_not be_valid }
  end
end
