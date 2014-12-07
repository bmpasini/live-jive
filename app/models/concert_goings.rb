class ConcertGoings < ActiveRecord::Base
	belongs_to :concert
	belongs_to :goer, class_name: "User"

	validates :rating, numericality: { only_integer: true, less_than_or_equal_to: 5 }, allow_blank: true
	validates :review, length: { maximum: 255 }, allow_blank: true
end
