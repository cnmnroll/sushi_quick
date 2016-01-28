class ShoppingCartDetail < ActiveRecord::Base
	belongs_to :merchandise
	belongs_to :shopping_cart
end
