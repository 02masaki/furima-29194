require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_address).to be_valid
    end
    it 'buildingがなくても保存できること' do
      @order_address.building = ""
      expect(@order_address).to be_valid
    end
    it 'tokenがないと購入できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
    it 'postal_codeが空だと購入できないこと' do
      @order_address.postal_code = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_address.postal_code = 0001111
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code is invalid")
    end
    it 'prefecture_idが1だと購入できないこと' do
      @order_address.prefecture_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")
    end
    it 'cityは空だと購入できないこと' do
      @order_address.city = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank", "City is invalid")
    end
    it 'addressは空だと購入できないこと' do
      @order_address.address = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address can't be blank")
    end
    it 'telが空だと購入できないこと' do
      @order_address.tel = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Tel can't be blank", "Tel is invalid")
    end
    it 'telが10文字未満だと保存できないこと' do
      @order_address.tel = 000000000
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Tel is invalid")
    end
    it 'telが12文字以上だと保存できないこと' do
      @order_address.tel = 000000000000
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Tel is invalid")
    end
  end
end
