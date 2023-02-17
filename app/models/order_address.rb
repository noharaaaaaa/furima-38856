class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_number, :prefecture_id, :city, :address, :building, :phone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :post_number, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, allow_blank: true}
    validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください", allow_blank: true}
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, allow_blank: true }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_number: post_number, prefecture_id: prefecture_id, city: city, address: address, building: building,
      phone_number: phone_number, order_id: order.id)
  end

end