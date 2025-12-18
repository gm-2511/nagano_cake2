# 商品作成（マスタ寄り：OK）
puts "-- Item seed --"

cake    = Genre.find_by!(name: "ケーキ")
pudding = Genre.find_by!(name: "プリン")
baked   = Genre.find_by!(name: "焼き菓子")

Item.find_or_create_by!(name: "洋梨のチーズタルト") do |item|
  item.price = 1200
  item.genre = cake
  item.is_active = true
end

Item.find_or_create_by!(name: "ザッハトルテ") do |item|
  item.price = 2900
  item.genre = cake
  item.is_active = true
end

Item.find_or_create_by!(name: "モンブラン") do |item|
  item.price = 2900
  item.genre = cake
  item.is_active = true
end

Item.find_or_create_by!(name: "卵たっぷり濃厚プリン") do |item|
  item.price = 500
  item.genre = pudding
  item.is_active = true
end

Item.find_or_create_by!(name: "紅茶のクッキー") do |item|
  item.price = 800
  item.genre = baked
  item.is_active = false
end

Item.find_or_create_by!(name: "フルーツタルト") do |item|
  item.price = 2900
  item.genre = cake
  item.is_active = true
end

Item.find_or_create_by!(name: "かぼちゃのプリン") do |item|
  item.price = 480
  item.genre = pudding
  item.is_active = true
end

Item.find_or_create_by!(name: "マカロンセット(8個)") do |item|
  item.price = 1200
  item.genre = baked
  item.is_active = true
end

Item.find_or_create_by!(name: "マカロンセット(16個)") do |item|
  item.price = 2000
  item.genre = baked
  item.is_active = false
end

Item.find_or_create_by!(name: "バナナケーキ") do |item|
  item.price = 980
  item.genre = cake
  item.is_active = true
end
