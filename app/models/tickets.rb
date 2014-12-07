class Tickets < ActiveRecord::Base
	belongs_to :concert

	def tiers
		["VIP", "Confort", "Pavillion", "Front Row", "Lounge"]
	end
end
