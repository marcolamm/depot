class Product < ActiveRecord::Base
  attr_accessible :available, :description, :image_url, :price, :title
	validates_presence_of :title, :description #:price
    validates_numericality_of :price 
	validates :price, :numericality => {:greater_than_or_equal_to => 0.05}
	validates :price, :format => { :with => /^\d+(\.[0-9][0|5]?)?$/,  :message => 'Must be  format e.g. 45.05 - smallest unit is 5 cents!!'}
											#/^(\d+)(\.\d(05)?)?$/
	validates :image_url, allow_blank: true, format: {
	with: %r{\.(gif|jpg|png)\Z}i,
	message: 'must be a URL for GIF, JPG or PNG image.'
	}
	default_scope :order => 'title'
	has_many :line_items
before_destroy :ensure_not_referenced_by_any_line_item
# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
	if line_items.count.zero?
return true
else
errors.add(:base, 'Line Items present' )
return false
end
	
	#validate :validate_swissPrice
	
	# protected
	# def validate_swissPrice
    # return if price = 1 
    # errors.add(:fields, "Betrag auf .05 Rappen eingeben")
  # end
end
end