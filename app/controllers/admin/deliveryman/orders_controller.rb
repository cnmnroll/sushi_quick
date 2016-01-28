class Admin::Deliveryman::OrdersController < Admin::Deliveryman::Base
	def index
		@orders = Order.where(delivery_status: 1).paginate(page: params[:page], per_page: 4).order('created_at')
		render layout: "deliveryman"
	end

	def update
		@order = Order.find(params[:id])
		@order.assign_attributes(params.require(:order).permit(:delivery_status))
		@order.save

		redirect_to action: :index
	end
end
