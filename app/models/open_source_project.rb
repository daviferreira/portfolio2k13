class OpenSourceProject < ActiveRecord::Base
  attr_accessible :description, :title, :url, :file

  has_attached_file :file, :styles => {:medium => "400x400#",
                                       :thumb => "118x118#"}

  validates :title, presence: true, length: { maximum: 140 }
end
