class TopController < ApplicationController
  def index
		@user = current_user
		@merchandises = Merchandise.display.getRecommend
		@sales = Merchandise.display.getSales
  end

	def not_found
		p 'top#not_found rescue '
		raise NotFound
	end
end
