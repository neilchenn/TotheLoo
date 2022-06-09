class Loo < ApplicationRecord
  acts_as_favoritable
  belongs_to :user
  has_many :reviews
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true, uniqueness: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_loo_fields,
    against: %w[name address facility_type accessible male female unisex parking],
    using: {
      tsearch: { prefix: true }
    }

    def average_rating
# logic for calculating averages
# return hash value for averages
    end
end
