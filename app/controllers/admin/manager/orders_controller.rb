class Admin::Manager::OrdersController < Admin::Manager::Base
	def index
		@orders = Order.all.order('created_at DESC')
		@orders = Order.paginate(page: params[:page], per_page: 3).order('created_at DESC')
	end
end
