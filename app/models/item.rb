class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :days
  belongs_to :user

  has_one_attached :image
  belongs_to :user
  #has_one :order
  
end
