require 'spec_helper'

describe Project do
  before { @project = Project.new(name: "Example Project",
                                  description: "Description",
                                  due_date: Time.now,
                                  published: true,
                                  url: "http://project.com") }

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:url) }
  it { should respond_to(:due_date) }
  it { should respond_to(:published) }

end
