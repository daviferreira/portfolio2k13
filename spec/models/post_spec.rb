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
  it { should respond_to(:tags) }
  it { should respond_to(:locale) }

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

  describe "Metas" do

    context "when meta title and description are not present" do

      before { @post.meta_title = @post.meta_description = "" }

      it "should have the title and abstract as metas" do
        meta_title, meta_description = @post.get_metas
        meta_title.should == @post.title
        meta_description.should == @post.abstract
      end

      # TODO: improve this test, it should not cut words etc.
      it "should limit the meta description to 160 characters" do
        @post.abstract = "s " * 200
        meta_title, meta_description = @post.get_metas
        meta_description.should == ("s " * 79) + "s"
      end

    end

  end

end
