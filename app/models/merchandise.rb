class Merchandise < ActiveRecord::Base
	has_many :shopping_cart_details
	has_many :order_details
	has_many :reviews
	has_many :relevances, class_name: 'MerchandiseRelevance'
	has_many :reverse_relevances, class_name: 'MerchandiseRelevance', foreign_key: :target_id


	attr_reader :uploaded_image
	validates :uploaded_image, presence: {on: [:create]}
	validates :merchandise_name, uniqueness: true, presence: true
	validates :price, :stock, presence: true, numericality: {
		greater_than_or_equal: 0
	}

	scope :category, -> (category) {
		where(category: category) unless category.to_i == 0
	}

	scope :sub_category, -> (sub_categories) {
		logger.debug("サブカテゴリクラス#{sub_categories.class}")
		logger.debug("サブカテゴリ空か#{sub_categories.empty? }")
		logger.debug("サブカテゴリnil?#{sub_categories.nil? }")
		logger.debug("サブカテゴリnil?#{sub_categories.length }")

		merchandises = Merchandise.arel_table
		unless sub_categories.length <= 1
			sql = merchandises[:sub_category].eq(sub_categories[0])
			sub_categories.each do |sub_category|
				sql = sql.or(merchandises[:sub_category].eq(sub_category))
			end
			logger.debug('サブカテゴリ')
			where(sql)
		end
	}

	scope :type_status, -> (type_status) {
		merchandises = Merchandise.arel_table
		unless type_status.length <= 1
			sql = merchandises[:type_status].eq(type_status[0])
			type_status.each do |type_status|
				sql = sql.or(merchandises[:type_status].eq(type_status))
			end
			logger.debug('type_status')
			where(sql)
		end
	}
	scope :search, -> (search) {
		where('merchandise_name LIKE ?', "%#{escape_like(search)}%") unless search.nil?
	}


	scope :getRecommend, -> {
		where(recommend: true)
	}

	scope :getSales, -> {
		order('sales DESC').limit(4)
	}

	scope :display, -> {
		where(display: true)
	}

	scope :hide, -> {
		where(display: false)
	}

	scope :select_display, -> (display) {
		if display == 'true'
			where(display: true)
		elsif display == 'false'
			where(display: false)
		end

	}

	def uploaded_image=(image)
		self.content_type = convert_content_type(image.content_type)
		self.data = image.read
		@uploaded_image = image
	end

	IMAGE_TYPE = {"image/jpeg" => "jpeg", "image/gif" => "gif", "image/png" => "png"}
	def extension
		IMAGE_TYPE[self.content_type]
	end

	def convert_content_type(ctype)
		ctype = ctype.rstrip.downcase
		case ctype
		when "image/pjepg" then "image/jpeg"
		when "image/jpg" then "image/jpeg"
		when "image/x-png" then "image/png"
		else ctype
		end
	end

	def self.escape_like(string)
		string.gsub(/[\\%_]/){|m| "\\#{m}"}
	end
end
