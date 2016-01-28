name = %w(まぐろ 中トロ 大トロ 生サーモン サーモン 漬けサーモン えび 赤えび 炙り赤えび いかおくら 納豆軍艦 ネギ塩まぐろ まぐろ山かけ コーン シーサラダ ツナサラダ かっぱ巻き 納豆巻き りんごジュース チーズケーキ メロン ポテト)

category = %w(1 1 1 1 1 1 1 1 1 1 1 1 1 1 11 1 1 1 2 2 2 2)
s_category = %w(1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3 4 5 5 6)
t_status = %w(1 1 1 2 2 2 3 3 3 5 5 1 1 4 4 4 15 5 6 9 8 15)
recommend = %w(true false false true false false flase false flase true false false false false true false true false false true true true false false false true true false false false true true)

0.upto(name.length - 1) do |idx|
	path = Rails.root.join("app/assets/images/blank.gif")
	file = Rack::Test::UploadedFile.new(path, "image/gif", true)
	merchandise = Merchandise.create(
		merchandise_name: name[idx],
		price: 100,
		stock: 10,
		category: category[idx],
		sub_category: s_category[idx],
		type_status: t_status[idx],
		uploaded_image: file,
		recommend: recommend[idx]
	)
end