class Order < ActiveRecord::Base
	belongs_to :user
	has_many :order_details, dependent: :destroy
	@@delivery_status = ["test", "注文済み", "発送済み"]
	@@page_token = {
		'shopping_carts#show': 1,
		'order#edit_address': 2,
		'order#create_address': 3,
		'order#confirm': 3
	}

	scope :select_year, -> (year) {
		p "year #{year}"
		where('created_at LIKE ?', "#{year}%") unless year.empty?
	}

	scope :select_month, -> (month) {
		p "month #{month}"
		where('created_at LIKE ?', "%-#{sprintf "%02d", month}-%") unless month.empty?
	}

	scope :select_day, -> (day) {
		p "day #{day}"
		where('created_at LIKE ?', "%-%-#{sprintf '%02d', day} %") unless day.empty?
	}

	class << self
		def delivery_status(idx)
			@@delivery_status[idx]
		end

		def page_token(previous)
			@@page_token[previous.to_sym]
		end

		def change_time(date)
			date.strftime('%Y年%m月%d日 %H:%M')
		end
	end
end
