require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品の保存' do
    context "商品が保存できる場合" do
      it "画像、テキスト、商品名、カテゴリー、状態、負担、地域、所用日数と価格があればツイートは保存される" do
        expect(@item).to be_valid
      end
    end
    context "商品が保存できない場合" do
      it "画像がないと保存できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end     
      it "商品名がないと保存できない" do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it "テキストがない商品は保存できない" do
        @item.content = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it "カテゴリー選択が1だと保存できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it "商品の状態が1だと保存できない" do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end
      it "配送料の負担の選択が1だと保存できない" do
        @item.burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Burden must be other than 1")
      end     
      it "発送減の地域が1だと保存できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end      
      it "所用日数が1だと保存できない" do
        @item.duration_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Duration must be other than 1")
      end
      it "価格がないと保存できない" do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank", "Price is not a number")
      end
      it "価格が300円未満では保存できない" do
        @item.price = 290
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
      end
      it "価格が9999999円越えでは保存できない" do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it "ユーザーが紐付いていないとツイートは保存できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end
