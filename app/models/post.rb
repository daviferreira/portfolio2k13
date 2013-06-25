class Post < ActiveRecord::Base
  attr_accessible :abstract, :block_comments, :body, :external_url,
                  :meta_description, :meta_title, :published, :published_date,
                  :title, :tags, :locale

  is_sluggable :title
  attr_accessible :cached_slug # for import only

  validates_presence_of :title, :abstract, :body

  scope :published, :conditions => { :published => true }, :order => "posts.published_date DESC"
  scope :published_local, :conditions => { :published => true, :external_url => '' }, :order => 'posts.published_date DESC'

  def get_metas
    [get_meta_title, get_meta_description]
  end

  private
      def get_meta_title
        if self.meta_title.nil? or self.meta_title.empty?
          self.title
        else
          self.meta_title
        end
      end

      # TODO: refactor, transform word limit into helper
      def get_meta_description
        if self.meta_description.nil? or self.meta_description.empty?
          self.abstract.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= 160);ob << (" " + x)}.strip
        else
          self.meta_title
        end
      end

end
