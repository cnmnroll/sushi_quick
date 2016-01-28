class ApplicationController < ActionController::Base
	class UnAuthorizedError < StandardError; end
	class UnDeliverymanError < StandardError; end
	class UnManagerError < StandardError; end
	class ShoppingCartEmptyError < StandardError; end
	class UnStockError < StandardError; end
	class UnLimitError < StandardError; end
	class NotFound < StandardError; end

	rescue_from UnAuthorizedError, with: :rescue_authentication
	rescue_from UnDeliverymanError, with: :rescue_admin
	rescue_from UnManagerError, with: :rescue_admin
	rescue_from ShoppingCartEmptyError, with: :rescue_shopping_cart_empty
	rescue_from UnStockError, with: :rescue_stock
	rescue_from UnLimitError, with: :rescue_limit
	rescue_from NotFound, with: :rescue_404

	protect_from_forgery with: :exception

	private
	def current_user
		User.find_by(id: session[:user_id]) if session[:user_id]
	end

	def authenticate_user
		raise UnAuthorizedError if (@user = current_user).nil?
	end

	def rescue_authentication(exception)
		@message = "ユーザログインを行ってください。3秒後にログインページに移動します。"
		render 'errors/error', :layout => 'auto_login_page'
	end

	# def rescue_manager(exception)
	# 	@message = "店長権限を持つアカウントでログインしてください。3秒後にログインページに移動します。"
	# 	render 'errors/error', :layout => 'auto_login_page'
	# end

	# def rescue_deliveryman(exception)
	# 	@message = "店長または配達員権限があるアカウントでログインしてください。3秒後にログインページに移動します。"
	# 	render 'errors/error', :layout => 'auto_login_page'
	# end



	def rescue_admin(exception)
		@message = "正しい管理者権限を持つアカウントでログインしてください。"
		render 'errors/error', :layout => 'auto_login_page'
	end

	def rescue_stock(exception)

		@message = "在庫がありません。"
		render 'errors/error', :layout => 'auto_back'
	end

	def rescue_shopping_cart_empty
		@message = "ショッピングカートが空なりました。"
		render 'errors/error', :layout => 'auto_search'
	end

	def rescue_limit(exception)
		@message = "注文数の上限を超えています。"
		render 'errors/error', :layout => 'auto_back'
	end

	def rescue_404(exception)
		@message = "ページが見つかりません。"
		render 'errors/error'
	end
	helper_method :current_user
end
