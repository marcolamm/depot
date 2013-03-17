class Product < ActiveRecord::Base
  attr_accessible :available, :description, :image_url, :price, :title
  validates_presence_of :title, :description, :price
   # validation_numerically_of : price
end
