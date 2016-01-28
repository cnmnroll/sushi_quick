class UserRank < ActiveRecord::Base

	class << self
		def getUserRankName(user)
			UserRank.find(user.user_rank_id).name
		end
		def getUserRank(total)
			ranks = UserRank.all
			ranks.each do |rank|
				if rank.upper_bound == 0 || rank.lower_bound <= total && total <= rank.upper_bound
					return rank.id
				end
			end
		end

		def getBronze
			return 1
		end

		def getSilver
			return 2
		end

		def getGold
			return 3
		end

		def getDiscount(id)
			return UserRank.find(id).discount
		end

		def getFinalTotal(user)
			 (user.shopping_cart.total - user.shopping_cart.total * 0.01 * getDiscount(user.user_rank_id)).ceil
		end
	end
end
