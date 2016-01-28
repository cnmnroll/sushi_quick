class Form::Contact
	include ActiveModel::Model
	include EmailAddressChecker

	attr_accessor :title, :contents, :mail, :name

	validates :title, :contents, presence: true
	validate :check_email

	private
	def check_email
		errors.add(:mail, :invalid) unless well_formed_as_email_address(mail)
	end
end