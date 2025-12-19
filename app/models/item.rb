class Item < ApplicationRecord
  belongs_to :genre
  has_one_attached :image
  has_many :order_details, dependent: :destroy
  belongs_to :genre, optional: true

  validates :name, presence: true                 # 名前は必須
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }  # 価格は正の整数
  #validates :genre_id, presence: true            # ジャンル選択必須

  def with_tax_price
  (price * 1.1).floor
  end

  # 画像を返すメソッド
  def get_image
    if image.attached?
      image
    else
      'no_image.png'  # public/images/no_image.png を用意しておく
    end
  end
end
