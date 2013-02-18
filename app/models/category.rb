class Category < ActiveRecord::Base
  attr_accessible :name, :scope

  has_many :projects

  validates :name, presence: true, length: { maximum: 40 }
  validates_presence_of :scope

  default_scope order: "categories.name ASC" 
end
