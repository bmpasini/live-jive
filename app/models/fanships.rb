class Fanships < ActiveRecord::Base
	belongs_to :fan, class_name: "User"
	belongs_to :band
end