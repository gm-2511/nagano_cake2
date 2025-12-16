# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# =====================

# =====================
# ジャンル作成
# =====================
cake    = Genre.find_or_create_by!(name: "ケーキ")
pudding = Genre.find_or_create_by!(name: "プリン")
baked   = Genre.find_or_create_by!(name: "焼き菓子")
candy   = Genre.find_or_create_by!(name: "キャンディ")

# =====================
# 商品作成
# =====================
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

# =====================
# 会員作成（1ページ目想定）
# =====================
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
    customer.first_name_kana = ""
    customer.last_name_kana  = ""
    customer.post_code = "000-0000"
    customer.address = "東京都"
    customer.telephone_number = "0000000000"
    customer.is_active = c[:is_active]
    customer.password = "password"
    customer.password_confirmation = "password"
  end
end

# =====================
# 注文用会員（会員一覧2ページ目以降）
# =====================
order_customers = [
  { last_name: "石倉", first_name: "基之", email: "ishikura@example.com" },
  { last_name: "城戸", first_name: "妙子", email: "kido@example.com" },
  { last_name: "林田", first_name: "英世", email: "hayashida@example.com" },
  { last_name: "保坂", first_name: "富美子", email: "hosaka@example.com" },
  { last_name: "大西", first_name: "真理", email: "onishi@example.com" },
  { last_name: "富永", first_name: "佐吉", email: "tominaga@example.com" },
  { last_name: "菊地", first_name: "武夫", email: "kikuchi@example.com" },
  { last_name: "海老原", first_name: "一花", email: "ebihara@example.com" }
]

order_customers.each do |c|
  Customer.find_or_create_by!(email: c[:email]) do |customer|
    customer.first_name = c[:first_name]
    customer.last_name  = c[:last_name]
    customer.first_name_kana = ""
    customer.last_name_kana  = ""
    customer.post_code = "000-0000"
    customer.address = "東京都"
    customer.telephone_number = "0000000000"
    customer.is_active = true
    customer.password = "password"
    customer.password_confirmation = "password"
  end
end

# =====================
# 管理者作成
# =====================
Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end

# =====================
# 注文データ（注文履歴一覧 見本どおり）
# =====================
order_data = [
  { email: "ishikura@example.com", created_at: "2019-11-20 23:55:12", quantity: 1, status: :waiting_payment },
  { email: "hoge@example.com",     created_at: "2019-11-20 14:22:19", quantity: 8, status: :waiting_payment },
  { email: "kido@example.com",     created_at: "2019-11-19 00:08:42", quantity: 3, status: :payment_confirmed },
  { email: "hayashida@example.com",created_at: "2019-11-18 23:55:12", quantity: 10, status: :in_production },
  { email: "hosaka@example.com",   created_at: "2019-11-16 09:25:38", quantity: 1, status: :preparing_shipment },
  { email: "onishi@example.com",   created_at: "2019-11-12 11:42:19", quantity: 1, status: :shipped },
  { email: "tominaga@example.com", created_at: "2019-11-12 11:04:22", quantity: 2, status: :shipped },
  { email: "kikuchi@example.com",  created_at: "2019-11-12 00:04:53", quantity: 8, status: :shipped },
  { email: "ebihara@example.com",  created_at: "2019-11-11 22:18:13", quantity: 1, status: :shipped },
  { email: "hosaka@example.com",   created_at: "2019-11-10 00:09:00", quantity: 1, status: :shipped }
]

item = Item.first

order_data.each do |data|
  customer = Customer.find_by!(email: data[:email])

  order = Order.create!(
    customer: customer,
    status: data[:status],
    created_at: data[:created_at],
    updated_at: data[:created_at]
  )

  OrderDetail.create!(
    order: order,
    item: item,
    amount: data[:quantity],
    price: item.price
    making_status: :cannot_start
  )
end

# 顧客作成
customer = Customer.create!(
  first_name: "花子",
  last_name: "山田",
  post_code: "150-0041",
  address: "東京都渋谷区神南1丁目19–11 八一夕工一夕了24階",
  email: "hoge@example.com",
  password: "password"
)

# ダミー注文作成
Order.create!(
  customer: customer,
  total_quantity: 3,
  status: :waiting_payment,
  payment_method: :bank_transfer,  # 支払方法
  created_at: "2019-11-20 14:22:19",
  updated_at: "2019-11-20 14:22:19"
)