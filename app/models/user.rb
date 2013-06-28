class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :name, :presence => true, length: { maximum: 50 }
end
