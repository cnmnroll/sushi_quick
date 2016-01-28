# Preview all emails at http://localhost:3000/rails/mailers/mailer
class MailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mailer/sendmail_contact
  def sendmail_contact
    Mailer.sendmail_contact
  end

end
