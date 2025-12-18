# 管理者作成（マスタデータ：OK）
puts "-- Admin seed --"

Admin.find_or_create_by!(email: "admin@example.com") do |admin|
  admin.password = "password"
  admin.password_confirmation = "password"
end
