class ConcertList < ActiveRecord::Base
	has_many :recommendations
	has_many :concerts, through: :recommendations
	
	belongs_to :list_owner, class_name: "User"

	validates :list_owner_id, presence: true

	def set_recommendation(concert)
		recommendations.create(concert_id: concert.id)
	end
end
