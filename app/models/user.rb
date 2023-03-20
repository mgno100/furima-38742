class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :last_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください'}
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください'}
    validates :last_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナ文字を使用してください'}
    validates :first_name_kana, format: {with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナ文字を使用してください'}
    validates :birthday
  end
      
  validates :password, :encrypted_password, format: {with: /\A[a-zA-Z0-9]+\z/}
end
