class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :family_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力してください。"}
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力してください。"}
    validates :family_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力して下さい。"}
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力して下さい。"}
    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i	}, uniqueness: true
    validates :password, format: {with: /\A[a-zA-Z0-9]+\z/}, length: { minimum: 6 }
    validates :birth_date
  end
end