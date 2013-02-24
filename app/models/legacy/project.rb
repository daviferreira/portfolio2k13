class Legacy::Project < Legacy::Base
  has_attached_file :screenshot, :styles => { :medium => "400x400#", :thumb => "80x80#" }
end
