class Post < ActiveRecord::Base
  attr_accessible :abstract, :block_comments, :body, :external_url,
                  :meta_description, :meta_title, :published, :published_date,
                  :title, :tags, :locale

  is_sluggable :title, { :use_cache => false }

  validates_presence_of :title, :abstract, :body

  scope :published, :conditions => { :published => true },
                    :order => "posts.published_date DESC"
  scope :published_local, :conditions => { :published => true,
                                          :external_url => '' },
                          :order => 'posts.published_date DESC'

  def get_metas
    [get_meta_title, get_meta_description]
  end

  private
      def get_meta_title
        return self.meta_title if self.meta_title.present?
        self.title
      end

      def get_meta_description
        return self.meta_description if self.meta_description.present?
        create_meta_description
      end

      def create_meta_description
        self.abstract.split(" ").each_with_object("") do |x, ob|
          break ob unless (ob.length + " ".length + x.length <= 160)
          ob << (" " + x)
        end.strip
      end

end
