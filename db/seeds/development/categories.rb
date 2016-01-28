name = %w(寿司 サイドメニュー)
0.upto(name.length - 1) do |idx|
	Category.create(
		category_name: name[idx]
	)
end
 