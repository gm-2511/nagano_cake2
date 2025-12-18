class Address < ApplicationRecord

    belongs_to :customer

    validates :name, :post_code, :address, presence: true

    # プルダウン表示用のメソッド
  def shipping_info
    '〒' + post_code + ' ' + address + ' ' + name
  end

end
