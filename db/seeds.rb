# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ジャンル作成
cake = Genre.create!(name: "ケーキ")
pudding = Genre.create!(name: "プリン")
baked = Genre.create!(name: "焼き菓子")

# 商品作成
Item.create!([
  { name: "洋梨のチーズタルト", price: 1200, genre: cake, is_active: true },
  { name: "ザッハトルテ", price: 2900, genre: cake, is_active: true },
  { name: "モンブラン", price: 2900, genre: cake, is_active: true },
  { name: "卵たっぷり濃厚プリン", price: 500, genre: pudding, is_active: true },
  { name: "紅茶のクッキー", price: 800, genre: baked, is_active: false },
  { name: "フルーツタルト", price: 2900, genre: cake, is_active: true },
  { name: "かぼちゃのプリン", price: 480, genre: pudding, is_active: true },
  { name: "マカロンセット(8個)", price: 1200, genre: baked, is_active: true },
  { name: "マカロンセット(16個)", price: 2000, genre: baked, is_active: false },
  { name: "バナナケーキ", price: 980, genre: cake, is_active: true }
])