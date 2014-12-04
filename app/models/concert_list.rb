class ConcertList < ActiveRecord::Base
	has_many :recommendations
	has_many :concerts, through: :recommendations
	
	belongs_to :list_owner, class_name: "User"
end
