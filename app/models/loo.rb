class Loo < ApplicationRecord
  acts_as_favoritable
  belongs_to :user
  has_many :reviews
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true
end
