class Time
	class << self
		def change_time(date)
			date.strftime('%Y年%m月%d日 %H:%M')
		end

	end
end