class Photo < ActiveRecord::Base
  attr_accessible :order, :project_id, :title
end
