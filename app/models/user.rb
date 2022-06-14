class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :loos, dependent: :destroy
  has_many :reviews, dependent: :destroy
  acts_as_favoritor
  has_many :favorite_loos, through: :favorites, source: :favoritable, source_type: "Loo"
end
