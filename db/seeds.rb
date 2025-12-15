# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ジャンル作成
cake = Genre.find_or_create_by!(name: "ケーキ")
pudding = Genre.find_or_create_by!(name: "プリン")
baked = Genre.find_or_create_by!(name: "焼き菓子")

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

customers = [
  { first_name: "花子", last_name: "山田", email: "hoge@example.com", is_active: true },
  { first_name: "毅雄", last_name: "松尾", email: "bbb@test.jp", is_active: true },
  { first_name: "乃香", last_name: "越智", email: "ccc@test.jp", is_active: true },
  { first_name: "寧音", last_name: "宮下", email: "ddd@test.jp", is_active: true },
  { first_name: "遥菜", last_name: "棚橋", email: "eee@test.jp", is_active: true },
  { first_name: "菜帆", last_name: "大野", email: "fff@test.jp", is_active: true },
  { first_name: "喜晴", last_name: "花井", email: "ggg@test.jp", is_active: false },
  { first_name: "秀子", last_name: "金沢", email: "hhh@test.jp", is_active: true },
  { first_name: "里沙", last_name: "前田", email: "iii@test.jp", is_active: true },
  { first_name: "長次郎", last_name: "小野", email: "jjj@test.jp", is_active: true },
  { first_name: "拓海", last_name: "佐藤", email: "takumi.sato@example.com", is_active: true }
]

customers.each do |c|
  Customer.find_or_create_by!(email: c[:email]) do |customer|
    customer.first_name = c[:first_name]
    customer.last_name  = c[:last_name]
    customer.name       = "#{c[:first_name]} #{c[:last_name]} #{SecureRandom.hex(2)}"
    customer.is_active  = c[:is_active]
    customer.password   = "password"
    customer.password_confirmation = "password"
  end
end


Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end