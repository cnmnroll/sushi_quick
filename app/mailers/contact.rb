class Contact < ApplicationMailer
	default from: 'umtaddress@gmail.com'

	def send_contact
		@contents = 'Hello'
		mail to: 'r777777r@gmail.com', subject: 'ApplicationMailer test'

	end
end
