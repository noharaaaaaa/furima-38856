class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item, dependent: :destroy
  has_one :address, dependent: :destroy
end
