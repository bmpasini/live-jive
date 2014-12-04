class ConcertGoings < ActiveRecord::Base
	belongs_to :concert
	belongs_to :goer, class_name: "User"
end
