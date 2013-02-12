require 'spec_helper'

describe Category do
  before { @category = Category.new(name: "Example Project") }

  subject { @category }

  it { should respond_to(:name) }
  it { should respond_to(:projects) }

  it { should be_valid }

  describe "when name is not present" do
    before { @category.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @category.name = "a" * 41 }
    it { should_not be_valid }
  end

end
