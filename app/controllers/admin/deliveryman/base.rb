class Admin::Deliveryman::Base < ApplicationController
	before_action :deliveryman_login_required

	private
	def deliveryman_login_required
		if current_user.nil?
			raise UnDeliverymanError
		else
			raise UnDeliverymanError unless current_user.user_status == 2 || current_user.user_status == 3
		end
	end
end
