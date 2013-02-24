class Legacy::PostCategory < Legacy::Base
  belongs_to :post
  belongs_to :category
end
