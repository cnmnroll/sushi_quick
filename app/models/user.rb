class User < ActiveRecord::Base
	include EmailAddressChecker

	has_many :orders
	has_one :shopping_cart
	has_many :reviews
	accepts_nested_attributes_for :orders

	validates :user_name, :user_address, :user_lo, presence: true
	validates :user_lo, uniqueness: true
	validates :password, presence: {on: :create}, confirmation: true

	attr_accessor :password, :password_confirmation
	def password=(val)
		logger.debug('password=(val)が呼ばれました')
		if val.present?
			self.user_ps = BCrypt::Password.create(val)
		end
		@password = val
	end

	class << self
		def authenticate(name, password)
			user = find_by(user_lo: name)
			if user && user.user_ps.present? &&	BCrypt::Password.new(user.user_ps) == password
				user
			else
				nil
			end
		end

		def getManagerNumber
			return 2
		end

		def getDeliveryNumber
			return 3
		end
	end
end
