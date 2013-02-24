class Legacy::Photo < Legacy::Base
  has_attached_file :photo, :styles => { :medium => "400x400#", :thumb => "80x80#" }
end
