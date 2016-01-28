class Admin::Manager::Base < ApplicationController
	before_action :manager_login_required

	private
	def manager_login_required
		if current_user.nil?
			raise UnManagerError
		else
			raise UnManagerError unless current_user.user_status == 2
		end
	end
end
