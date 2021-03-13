class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :password, :password_confirmation, length: { minimum: 6 }, format: { with: /(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}/ }
    validates :nickname
    validates :birthday
  
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
      validates :first_name
      validates :last_name
    end

    with_options format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/ } do
      validates :first_name_kana
      validates :last_name_kana
    end
  end

  has_many :items
  has_many :orders
end
