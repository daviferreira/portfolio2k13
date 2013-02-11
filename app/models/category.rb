class Category < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, length: { maximum: 40 }
end
