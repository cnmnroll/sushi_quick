class Test < ApplicationMailer
	default from: 'r777777r@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.sendmail_contact.subject
  #
  def sendmail_contact
	 mail to: 'r777777r@gmail.com', subject: 'test mail'
  end
end
