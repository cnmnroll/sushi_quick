name = %w(ブロンズ シルバー ゴールド)
lower = %w(0 10000 40000)
upper = %w(9999 39999 0)
discount = %w(0 10 30)
0.upto(name.length - 1) do |idx|
	UserRank.create(
		name: name[idx],
		lower_bound: lower[idx],
		upper_bound: upper[idx],
		discount: discount[idx]
	)
end
