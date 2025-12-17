class Address < ApplicationRecord

    belongs_to :customer

    validates :name, :post_code, :address, presence: true

end
