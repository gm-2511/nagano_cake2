class Customer < ApplicationRecord
  # 名前とメールは必須
  #validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # デフォルト値
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.is_active = true if is_active.nil?
  end
end
