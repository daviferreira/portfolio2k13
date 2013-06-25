class Legacy::Post < Legacy::Base
  has_many :post_categories, :dependent => :destroy
  has_many :categories, :through => :post_categories
  has_many :comments
end
