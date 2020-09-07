require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemail、passwordとpassword_confirmation、姓名（フリガナ）、emailが存在すれば登録できる" do
        expect(@user).to be_vaild
      end
      it "passwordが半角英数字の6文字以上であれば登録できる" do
        @user.password = "aiueo23"
        expect(@user).to be_vaild
      end 
      it "名前が全角ひらがな、全角カタカナ、漢字なら登録できる"
        @user.family_name = "山なカ"
        @user.first_name = "香おル"
        expect(@user).to be_vaild
      end
      it "フリガナが全角カタカナなら登録できる"
        @user.family_name_kana = "ヤマナカ"
        @user.first_name_kana = "カオル"
        expect(@user).to be_vaild
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nick_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nick_name can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end