class Recommendation < ActiveRecord::Base
	belongs_to :concert
	belongs_to :concert_list
end
