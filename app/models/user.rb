class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :birth_year, presence: true
  validates :first_name, :last_name, presence: true,
                                     format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,
                                               message: 'is invalid. Input full-width characters' }
  validates :first_name_kana, :last_name_kana, presence: true,
                                               format: { with: /\A[ァ-ヶー－]+\z/,
                                                         message: 'is invalid. Input full-width katakana characters' }

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers' }

  has_many :items
  # has_many :orders
end
