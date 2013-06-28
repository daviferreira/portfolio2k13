class Post < ActiveRecord::Base
  attr_accessible :abstract, :block_comments, :body, :external_url,
                  :meta_description, :meta_title, :published, :published_date,
                  :title, :tags, :locale

  is_sluggable :title, { :use_cache => false }

  validates_presence_of :title, :abstract, :body

  scope :published, :conditions => { :published => true }, :order => "posts.published_date DESC"
  scope :published_local, :conditions => { :published => true, :external_url => '' }, :order => 'posts.published_date DESC'

  def get_metas
    [get_meta_title, get_meta_description]
  end

  private
      def get_meta_title
        if self.meta_title.present?
          self.meta_title
        else
          self.title
        end
      end

      # TODO: refactor, transform word limit into helper
      def get_meta_description
        if self.meta_description.present?
          self.meta_title
        else
          self.abstract.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= 160);ob << (" " + x)}.strip
        end
      end

end
