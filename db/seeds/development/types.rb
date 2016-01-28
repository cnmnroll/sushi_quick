name = %w(まぐろ系 サーモン系 えび系 サラダ系 粘り系 ジュース お酒 果物 ケーキ )
0.upto(name.length - 1) do |idx|
	Type.create(
		type_name: name[idx]
	)
end