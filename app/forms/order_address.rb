class OrderAddress

  include ActiveModel::Model
  attr_accessor :prefecture_id, :city, :address, :building, :tel, :postal_code, :token, :item_id, :user_id
  
  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id, numericality: { other_than: 1}
    validates :city, format: {with: /\A[一-龥ぁ-ん]/}
    validates :address
    validates :tel, format: {with: /\A\d{10,11}\z/}
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id )
    Address.create(prefecture_id: prefecture_id, city: city, address: address, building: building, postal_code: postal_code, tel: tel, order_id: order_id)
  end

end