class Review < ActiveRecord::Base
	belongs_to :merchandise
	belongs_to :user

	class << self
		def change_star(count)
		tmp = ''
			count.times do |idx|
				tmp << '★'
			end
			tmp
		end
	end
end


