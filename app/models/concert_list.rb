class ConcertList < ActiveRecord::Base
	has_many :recommendations
	has_many :concerts, through: :recommendations
	
	belongs_to :list_owner, class_name: "User"

	validates :list_owner_id, presence: true
end
