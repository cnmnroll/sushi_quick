class SessionsController < ApplicationController
	def create
		user = User.authenticate(params[:name], params[:password])
		if user
			session[:user_id] = user.id
			redirect_to :root
		else
			flash.alert = "名前とパスワードが一致しません。"
			redirect_to :login_user
		end
	end

	def destroy
		session.delete(:user_id)
		redirect_to :root
	end
end
