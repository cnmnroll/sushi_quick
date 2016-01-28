class ShoppingCartDetailsController < ApplicationController
	before_action :authenticate_user
	before_action :check_stock, only: [:create]
	before_action :check_stock2, only: [:update]

	def edit
		@shopping_cart = @user.shopping_carts
		unless params[:ajax_hundler].blank?
			if params[:ajax_hundler] == 'edit_address'
				create_address_ajax
			end
		end
		session[:address] = @user.user_address if session[:address].nil?
	end
	def index
		@shopping_cart = current_user.shopping_cart.shopping_cart_details
		@count = @user.shopping_cart.shopping_cart_details.count
		unless @shopping_cart.count == 0
			render "cart"
		else
			render 'nocart'
		end
	end

	def destroy
		detail = ShoppingCartDetail.find(params[:id])
		@user.shopping_cart.total -= detail.sub_total
		detail.destroy
		@user.shopping_cart.save
		redirect_to :back
	end

	def update
		p 'shopping_carts update 呼び出し'
		@shopping_cart = @user.shopping_cart.shopping_cart_details
		@cart_detail = ShoppingCartDetail.find(params[:id])
		@total = (params[:quantity].to_i - @cart_detail.quantity) * @cart_detail.merchandise.price
		@cart_detail.quantity = params[:quantity]
		@cart_detail.sub_total = params[:quantity].to_i * @cart_detail.merchandise.price
		@cart_detail.save
		update_total
		select_render_ajax
	end

	def create
		@merchandise = Merchandise.find(params[:id])
		@total = params[:quantity].to_i * @merchandise.price
		if @cart_detail
			@cart_detail.assign_attributes(
				quantity: @cart_detail.quantity + params[:quantity].to_i,
				sub_total: @cart_detail.sub_total += @total
			)
			@cart_detail.save
		else
			detail = ShoppingCartDetail.new(
				quantity: params[:quantity],
				sub_total: @total
			)
			detail.merchandise = @merchandise
			@user.shopping_cart.shopping_cart_details << detail
		end
		update_total
		redirect_to action: :index
	end

	private
	def check_stock
		p 'check_stock 呼び出し'
		@merchandise = Merchandise.find(params[:id])
		@cart_detail = @user.shopping_cart.shopping_cart_details.find_by(merchandise_id: params[:id])
		if @cart_detail
			raise UnStockError if @merchandise.stock < params[:quantity].to_i + @cart_detail.quantity
			raise UnLimitError if 10 < params[:quantity].to_i + @cart_detail.quantity
		else
			raise UnStockError if @merchandise.stock < params[:quantity].to_i
		end
		raise UnLimitError if 10 < params[:quantity].to_i
	end
	def check_stock2
		p 'check_stock 呼び出し'
		@merchandise = ShoppingCartDetail.find(params[:id]).merchandise
		p "@merchandise.stock #{@merchandise.stock}"
		p "params[:quantity] #{params[:quantity]}"
		raise UnStockError if @merchandise.stock < params[:quantity].to_i
	end
	def update_total
		p 'update_total呼び出し'
		@user.shopping_cart.total += @total
		@user.shopping_cart.save
		p 'update_total終了'
	end
	def select_render_ajax
		if params[:ajax_hundler] == 'confirm'
			render 'confirm'
		else
			render
		end
	end
end
