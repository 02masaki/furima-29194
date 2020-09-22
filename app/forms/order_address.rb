class OrderAddress

  include ActiveModel::Model
  attr_accessor :prefecture_id, :city, :address, :building, :tel, :postal_code, :token, :item_id, :user_id
  
  POSTAL_CODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/
  CITY_REGEX = /\A[一-龥ぁ-ん]/
  TEL_REGEX = /\A\d{10,11}\z/

  with_options presence: true do
    validates :postal_code, format: {with: POSTAL_CODE_REGEX}
    validates :prefecture_id, numericality: { other_than: 1}
    validates :city, format: {with: CITY_REGEX}
    validates :address
    validates :tel, format: {with: TEL_REGEX}
    validates :token
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id )
    Address.create(prefecture_id: prefecture_id, city: city, address: address, building: building, postal_code: postal_code, tel: tel, order_id: order.id)
  end

end