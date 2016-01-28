class Mailer < ActionMailer::Base
  default from: "r777777r@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.sendmail_contact.subject
  #
  def sendmail_contact(contact)
		@contact = contact
	 mail to: contact.mail, subject: contact.title
  end

	def create_user

	end

	def create_order(user, order)
		@order = order
		mail to: user.user_email, subject: '【寿司クイック】注文完了致しました。'
	end
end
