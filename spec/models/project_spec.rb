require 'spec_helper'

describe Project do
  before { 
    category = Category.create(name: "Example Category")
    @project = Project.new(name: "Example Project",
                           description: "Description",
                           due_date: Time.now,
                           published: true,
                           url: "http://project.com",
                           category_id: category.id)
  }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:url) }
  it { should respond_to(:due_date) }
  it { should respond_to(:published) }
  it { should respond_to(:category_id) }
  it { should respond_to(:photos) }
  it { should respond_to(:tags) }

  it { should be_valid }

  describe "when name is not present" do
    before { @project.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @project.name = "a" * 141 }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @project.description = "" }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { @project.url = "" }
    it { should_not be_valid }
  end

  describe "when due_date is not present" do
    before { @project.due_date = "" }
    it { should_not be_valid }
  end

  describe "when category id is not present" do
    before { @project.category_id = nil }
    it { should_not be_valid }
  end

  describe "when category is not present" do
    before { @project.category_id = 9999 }
    it { should_not be_valid }
  end


  describe "default scope" do
    it "should order projects by due date" do
      category = Category.create(name: "Category")
      p1 = Project.create(name: "Project 1",
                          description: "Project 1 description",
                          due_date: "2013-01-27",
                          published: true,
                          url: "http://project1.com",
                          category_id: category.id)
      p2 = Project.create(name: "Project 2",
                          description: "Project 2 description",
                          due_date: "2013-02-03",
                          published: true,
                          url: "http://project2.com",
                          category_id: category.id)
      p3 = Project.create(name: "Project 3",
                          description: "Project 3 description",
                          due_date: "2011-11-11",
                          published: true,
                          url: "http://project3.com",
                          category_id: category.id)
      projects = Project.all
      projects[0].should == p2
      projects[1].should == p1
      projects[2].should == p3
    end
  end

  describe "published scope" do
    it "should only list published projects and order by due date" do
      category = Category.create(name: "Category")
      p1 = Project.create(name: "Project 1",
                          description: "Project 1 description",
                          due_date: "2013-01-31",
                          published: true,
                          url: "http://project1.com",
                          category_id: category.id)
      p2 = Project.create(name: "Project 2",
                          description: "Project 2 description",
                          due_date: "2013-02-03",
                          published: false,
                          url: "http://project2.com",
                          category_id: category.id)
      p3 = Project.create(name: "Project 3",
                          description: "Project 3 description",
                          due_date: "2011-11-11",
                          published: true,
                          url: "http://project3.com",
                          category_id: category.id)
      projects = Project.published
      projects.count.should == 2
      projects[0].should == p1
      projects[1].should == p3

    end
  end

end
