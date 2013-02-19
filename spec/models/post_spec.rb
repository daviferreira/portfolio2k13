require 'spec_helper'

describe Post do
  before {
    @post = Post.new(:title => "Post",
                     :abstract => "Post Abstract",
                     :body => "Post Body")
  }

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:abstract) }
  it { should respond_to(:body) }
  it { should respond_to(:published) }
  it { should respond_to(:published_date) }
  it { should respond_to(:meta_title) }
  it { should respond_to(:meta_description) }
  it { should respond_to(:block_comments) }
  it { should respond_to(:external_url) }
  it { should respond_to(:tag_list) }

  it { should be_valid }

  describe "when title is not present" do
    before { @post.title = " " }
    it { should_not be_valid }
  end

  describe "when abstract is not present" do
    before { @post.abstract = " " }
    it { should_not be_valid }
  end

  describe "when body is not present" do
    before { @post.body = " " }
    it { should_not be_valid }
  end

end
