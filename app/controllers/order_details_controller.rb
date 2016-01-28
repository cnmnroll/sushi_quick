class OrderDetailsController < ApplicationController
	before_action :check_delivery_status
	def delete_detail
		@order_detail = OrderDetail.find(params[:id])
		@order_detail.destroy

		@order.destroy if @order.order_details.count <= 0
		@order_detail.merchandise.stock += @order_detail.quantity
		@order_detail.merchandise.save
		redirect_to user_orders_path
	end

	def update
		@user = current_user
		@orders = @user.orders.order('created_at DESC')
		@order = Order.find(params[:order_id])
		user_total = @user.total - @order.total
		@detail = OrderDetail.find(params[:id])
		new_sub_total = params[:quantity].to_i * @detail.merchandise.price
		p "new_sub_total #{new_sub_total}"
		p "order.total #{@order.total}"
		p "order_detail.sub_total #{@detail.sub_total}"
		p "discount #{UserRank.getDiscount(UserRank.getUserRank(user_total))}"
		@order.total = @order.total - (@detail.sub_total - new_sub_total) * (100 - UserRank.getDiscount(UserRank.getUserRank(user_total))) * 0.01
		@detail.quantity = params[:quantity].to_i
		@detail.sub_total = params[:quantity].to_i * @detail.merchandise.price
		@order.save; @detail.save
		render
	end

	private
	def check_delivery_status
		@order = Order.find(params[:order_id])
		unless @order.delivery_status == 1
			flash.alert = "発送済みのためキャンセルできません。"
			redirect_to user_orders_path
		end
	end
end
