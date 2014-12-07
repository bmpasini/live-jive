class Concert < ActiveRecord::Base
	has_one :lineup
	has_many :bands, through: :lineups

	has_many :concert_goings
	has_many :goers, through: :concert_goings

	has_many :recommendations
	has_many :concert_lists, through: :recommendations
	
	has_many :tickets

	validates :title, presence: true
	validates :description, presence: true
	validates :buy_tickets_website, presence: true
end
