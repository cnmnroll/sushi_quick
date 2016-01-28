class OrdersController < ApplicationController
	before_action :authenticate_user
	before_action :check_shopping_cart, only: [:edit_address, :confirm, :new, :create]
	before_action :check_stock, only: [:create, :confirm]
	before_action :check_delivery_status, only: [:delete_order]

	def index
		@orders = @user.orders.order('created_at DESC')
		unless params[:order].nil?
			unless params[:order][:id].nil?
				@orders = @user.orders.where(id: params[:order][:id])
			else
			p 'params[:order] aru'
			@orders =	@orders.select_year(params[:order]["created_at(1i)"]).select_month(params[:order]["created_at(2i)"]).select_day(params[:order]["created_at(3i)"])
			end
		end
		@orders = @orders.paginate(page: params[:page], per_page: 3).order('created_at DESC')
	end

	def create
		@total = @user.shopping_cart.total; @puser_rank_id = @user.user_rank_id
		total = UserRank.getFinalTotal(@user); next_total = @user.total + total
		@user.shopping_cart.total = 0
		@user.assign_attributes(total: next_total, user_rank_id: UserRank.getUserRank(next_total))

		@order = @user.orders.create(user_address: @user.shopping_cart.address, total: total)
		@user.shopping_cart.address = nil
		@user.save; @user.shopping_cart.save
		@shopping_cart.each do |detail|
			@order.order_details.create(
				merchandise_id: detail.merchandise_id,
				quantity: detail.quantity,
				sub_total: detail.sub_total
			)
			detail.merchandise.sales += 1
			detail.merchandise.stock -= detail.quantity; detail.merchandise.save
			@shopping_cart.each do |detail2|
				next if detail == detail2
				relevance = detail.merchandise.relevances.where(target_id: detail2.merchandise.id).first
				p detail.merchandise.relevances
				if relevance.nil?
					relevance = MerchandiseRelevance.new
					p relevance
					relevance.target = detail.merchandise
					relevance.merchandise = detail2.merchandise
				end
				relevance.quantity += 1
				relevance.save
			end
		end
		@order_details = @order.order_details
		@user.shopping_cart.shopping_cart_details.destroy_all
		render "result"
	end

	def edit_address
		render "edit_address"
	end

	def confirm
		if params[:address].nil?
			@user.shopping_cart.address = @user.user_address if @user.shopping_cart.address.nil?
		else
			@user.shopping_cart.address = params[:address]
		end
		render 'edit_address'	unless @user.shopping_cart.save(context: :check_address)
	end

	def delete_order
		@order = Order.find(params[:id])
		@order.order_details.each do |detail|
			detail.merchandise.stock += detail.quantity
			detail.merchandise.save
		end
		@order.destroy
		redirect_to :back
	end

	private
	def check_shopping_cart
		@shopping_cart = @user.shopping_cart.shopping_cart_details
		raise ShoppingCartEmptyError if @shopping_cart.count == 0
	end

	def check_delivery_status
		@order = Order.find(params[:id])
		unless @order.delivery_status == 1
			flash.alert = "発送済みのためキャンセルできません。"
			redirect_to user_orders_path
		end
	end

	def check_stock
		@user.shopping_cart.shopping_cart_details.each do |detail|
			raise UnStockError if detail.merchandise.stock < detail.quantity
		end
	end
end
