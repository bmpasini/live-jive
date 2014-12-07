class Tickets < ActiveRecord::Base
	belongs_to :concert

	def tiers
		["VIP", "Confort", "Pavillion", "Front Row", "Lounge"]
	end
	
	validate :price, presence: true
	validate :how_many_left, presence: true
	validate :concert, presence: true
end
