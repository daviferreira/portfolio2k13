class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :projects

  validates :name, presence: true, length: { maximum: 40 }

  default_scope order: "categories.name ASC" 
end
