name = %w(にぎり 軍艦 巻き ドリンク デザート おつまみ)
0.upto(name.length - 1) do |idx|
	SubCategory.create(
		sub_category_name: name[idx]
	)
end