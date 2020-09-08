class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  NAME_LETTER = /\A[ぁ-んァ-ン一-龥]/
  NAME_YOMI = /\A[ァ-ヶー－]+\z/
  EMAIL_VAL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASS_VAL = /\A[a-zA-Z0-9]+\z/
  with_options presence: true do
    validates :family_name, format: { with: NAME_LETTER, message: "は全角で入力してください。"}
    validates :first_name, format: { with: NAME_LETTER, message: "は全角で入力してください。"}
    validates :family_name_kana, format: { with: NAME_YOMI, message: "は全角カタカナで入力して下さい。"}
    validates :first_name_kana, format: { with: NAME_YOMI, message: "は全角カタカナで入力して下さい。"}
    validates :email, format: {with: EMAIL_VAL}, uniqueness: true
    validates :password, format: {with: PASS_VAL}
    validates :birth_date
    validates :nick_name
  end
end