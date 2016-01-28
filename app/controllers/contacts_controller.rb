class ContactsController < ApplicationController
	def index

	end
	def new
		@contact = Form::Contact.new
		
	end
	def create
		@contact = Form::Contact.new(params[:form_contact])
		if @contact.valid?
			Mailer.sendmail_contact(@contact).deliver_now
		else
			render 'new'
		end
	end
end
