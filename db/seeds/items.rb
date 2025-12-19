# 商品作成（マスタ寄り：OK）
puts "-- Item seed --"

cake    = Genre.find_by!(name: "ケーキ")
pudding = Genre.find_by!(name: "プリン")
baked   = Genre.find_by!(name: "焼き菓子")

items_data = [
  {
    name: '洋梨のチーズタルト',
    introduction: '甘くて濃厚な洋梨のチーズタルトです。',
    genre_id: cake.id,
    image: File.open('./app/assets/images/pear_cheesecake.png'),
    price: 1200,
    is_active: true
  },
  {
    name: 'ザッハトルテ',
    introduction: '濃厚チョコレートとスポンジの絶妙な組み合わせ。',
    genre_id: cake.id,
    image: File.open('./app/assets/images/sacher_torte.png'),
    price: 2900,
    is_active: true
  },
  {
    name: 'モンブラン',
    introduction: '栗のペーストをたっぷり使った秋の味覚。',
    genre_id: cake.id,
    image: File.open('./app/assets/images/montblanc.png'),
    price: 500,
    is_active: true
  },
  {
    name: '卵たっぷり濃厚プリン',
    introduction: 'なめらかで濃厚な卵プリン。',
    genre_id: pudding.id,
    image: File.open('./app/assets/images/rich_pudding.png'),
    price: 500,
    is_active: true
  },
  {
    name: '紅茶のクッキー',
    introduction: '香り高い紅茶のクッキー。',
    genre_id: baked.id,
    image: File.open('./app/assets/images/tea_cookie.png'),
    price: 800,
    is_active: false
  },
  {
    name: 'フルーツタルト',
    introduction: '色とりどりのフルーツを贅沢に使用。',
    genre_id: cake.id,
    image: File.open('./app/assets/images/fruit_tart.png'),
    price: 2900,
    is_active: true
  },
  {
    name: 'かぼちゃのプリン',
    introduction: 'かぼちゃの甘みがぎゅっと詰まったプリン。',
    genre_id: pudding.id,
    image: File.open('./app/assets/images/pumpkin_pudding.png'),
    price: 480,
    is_active: true
  },
  {
    name: 'マカロンセット(8個)',
    introduction: 'カラフルで可愛いマカロン8個セット。',
    genre_id: baked.id,
    image: File.open('./app/assets/images/macaron8.png'),
    price: 1200,
    is_active: true
  },
  {
    name: 'マカロンセット(16個)',
    introduction: 'プレゼントにも最適なマカロン16個セット。',
    genre_id: baked.id,
    image: File.open('./app/assets/images/macaron16.png'),
    price: 2100,
    is_active: false
  },
  {
    name: 'バナナケーキ',
    introduction: 'しっとりバナナたっぷりのケーキ。',
    genre_id: cake.id,
    image: File.open('./app/assets/images/banana_cake.png'),
    price: 980,
    is_active: true
  }
]

items_data.each do |data|
  # find_or_initialize_by で既存商品を取得、なければ新規作成
  item = Item.find_or_initialize_by(name: data[:name])
  
  # 商品情報を上書き
  item.introduction = data[:introduction]
  item.genre_id     = data[:genre_id]
  item.price        = data[:price]
  item.is_active    = data[:is_active]
  item.save!

  # 画像を attach（既に添付済みの場合はスキップ）
  if data[:image].present? && !item.image.attached?
    item.image.attach(io: data[:image], filename: File.basename(data[:image].path))
  end
end
