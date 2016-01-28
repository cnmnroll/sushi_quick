class UsersController < ApplicationController
	before_action :authenticate_user, only: [:edit, :update, :show]
	after_action :check_user

	def edit
	end
	def show
	end
	def update
		@user.assign_attributes(user_params)
		if @user.save
			redirect_to @user
		else
			render 'edit'
		end
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.shopping_cart = ShoppingCart.new
		if @user.save
			flash.notice = '会員を登録しました。'
			render 'login'
		else
			render 'new'
		end
	end
	def login
		render :login
	end
	private
	def user_params
		params.require(:user).permit(:user_name, :user_address, :user_lo, :password, :password_confirmation)
	end

	def check_user
		if current_user
		end
	end
end
