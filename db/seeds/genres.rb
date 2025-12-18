# ジャンル作成（マスタデータ：OK）
puts "-- Genre seed --"

Genre.find_or_create_by!(name: "ケーキ")
Genre.find_or_create_by!(name: "プリン")
Genre.find_or_create_by!(name: "焼き菓子")
Genre.find_or_create_by!(name: "キャンディ")
