require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemail、passwordとpassword_confirmation、姓名（フリガナ）、emailが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが半角英数字の6文字以上であれば登録できる" do
        @user.password = "aiueo23"
        @user.password_confirmation = "aiueo23"
        expect(@user).to be_valid
      end 
      it "名前が全角ひらがな、全角カタカナ、漢字なら登録できる" do
        @user.family_name = "山なカ"
        @user.first_name = "香おル"
        expect(@user).to be_valid
      end
      it "フリガナが全角カタカナなら登録できる" do
        @user.family_name_kana = "ヤマナカ"
        @user.first_name_kana = "カオル"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nick_nameが空だと登録できない" do
        @user.nick_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nick name can't be blank")
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
        expect(another_user.errors.full_messages).to include("Email has already been taken", "Email has already been taken")
      end
      it "emailは@がないと登録できない" do
        @user.email = "aaaaa000com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid", "Email is invalid")
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
      it "passwordは「英字のみ」では登録できない" do
        @user.password = "aaaaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "passwordは「数字のみ」では登録できない" do
        @user.password = "000000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "姓は空だと登録できない" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it "名前は空だと登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "姓（フリガナ）は空だと登録できない" do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it "名前（フリガナ）は空だと登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "生年月日は空だと登録できない" do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it "姓は漢字、平仮名、カタカナ以外は登録できない" do
        @user.family_name = "02039aefe"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name は全角で入力してください。")
      end
      it "名前は漢字、平仮名、カタカナ以外は登録できない" do
        @user.first_name = "fihei23"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角で入力してください。")
      end
      it "姓（フリガナ）はカタカナ以外は登録できな" do
        @user.family_name_kana = "田中"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana は全角カタカナで入力して下さい。")
      end
      it "名前（フリガナ）はカタカナ以外は登録できない" do
        @user.first_name_kana = "真一"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カタカナで入力して下さい。")
      end
    end
  end
end