require 'spec_helper'

describe Photo do
  before {
    @photo = Photo.new(title: "Test Photo",
                       order: 1,
                       project_id: 1)
  }

  subject { @photo }

  it { should respond_to(:title) }
  it { should respond_to(:order) }
  it { should respond_to(:project) }

  it { should be_valid }
end
