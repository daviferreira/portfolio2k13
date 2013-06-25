# -*- encoding : utf-8 -*-
class Legacy::Comment < Legacy::Base
  belongs_to :post
  belongs_to :comment
  has_many :comments
end
