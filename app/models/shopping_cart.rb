class ShoppingCart < ActiveRecord::Base
	belongs_to :user
	has_many :shopping_cart_details


	validates :address, presence: true, on: :check_address
	class << self
		def getTotal(shoppingCart)
			shoppingCart.sum(:sub_total).to_i
		end
	end
end
