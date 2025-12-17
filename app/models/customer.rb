class Customer < ApplicationRecord
  has_many :orders
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items
  # 名前とメールは必須
  #validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :last_name_kana, format: { with: /\A[\p{katakana}\u{30FC}]+\z/, message: "はカタカナで入力してください" }, allow_blank: true
  validates :first_name_kana, format: { with: /\A[\p{katakana}\u{30FC}]+\z/, message: "はカタカナで入力してください" }, allow_blank: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # デフォルト値
  after_initialize :set_default_status, if: :new_record?

  has_many :addresses, dependent: :destroy

  private

  def set_default_status
    self.is_active = true if is_active.nil?
  end
end
