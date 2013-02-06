class Project < ActiveRecord::Base
  attr_accessible :description, :due_date, :name, :published, :url
end
