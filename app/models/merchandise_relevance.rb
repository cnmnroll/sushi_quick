class MerchandiseRelevance < ActiveRecord::Base
	belongs_to :merchandise, foreign_key: :target_id
	belongs_to :target, class_name: 'Merchandise', foreign_key: :merchandise_id
	scope :getRelevance, -> {
		order("quantity DESC").limit(4)
	}
end
