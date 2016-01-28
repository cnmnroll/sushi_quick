name = %w(ユーザ 管理者 配達係)
address = %w(神奈川県 埼玉県 東京都)
id = %w(user manager deliveryman)
status = %w(1 2 3)
0.upto(name.length - 1) do |idx|
	user = User.create(
		user_name: name[idx],
		user_address: address[idx],
		user_lo: id[idx],
		password: 1234,
		password_confirmation: 1234,
		user_status: status[idx],
		total: 5000000,
		user_email: 'umtaddress@gmail.com'
	)
	user.shopping_cart = ShoppingCart.new()
end
