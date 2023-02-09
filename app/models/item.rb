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
  #has_one :order 未実装のため
  
  #空の投稿を保存できないようにする
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'out of setting range' }
  validates :image, presence: true

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_id, numericality: { other_than: 1, message: "can't be blank"}

end
