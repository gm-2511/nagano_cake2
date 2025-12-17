namespace :db do
  desc "SQLite: 外部キーを考慮して ID をリセットし、データは保持する"
  task reset_ids_keep_data: :environment do
    connection = ActiveRecord::Base.connection

    puts "外部キー制約を一時的にOFF"
    connection.execute("PRAGMA foreign_keys = OFF")

    tables = %w[
      order_details
      orders
      customers
      items
    ]

    tables.each do |table|
      puts "処理中: #{table}"
      connection.execute("DELETE FROM sqlite_sequence WHERE name='#{table}'")
      connection.execute("INSERT INTO sqlite_sequence (name, seq) VALUES ('#{table}', 0)")
    end

    puts "外部キー制約をONに戻す"
    connection.execute("PRAGMA foreign_keys = ON")

    puts "完了: ID を 1 から振り直し、データは保持しました"
  end
end
