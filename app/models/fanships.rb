class Fanships < ActiveRecord::Base
	belongs_to :fan, class_name: "User"
	belongs_to :band

	validates :fan_id, presence: true
	validates :band_id, presence: true
end