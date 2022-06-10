class Loo < ApplicationRecord
  acts_as_favoritable
  belongs_to :user
  has_many :reviews, dependent: :destroy
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


  def average_star_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    # reviews.average(:star_rating).to_f
    (average_cleanliness_rating + average_flushing_power_rating + average_ambience_rating + average_toilet_paper_soap_rating) / 4
    # return reviews.sum(:star_rating).fdiv(reviews.count).to_i
  end

  def average_cleanliness_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    reviews.average(:cleanliness).to_f
    # return reviews.sum).fdiv(reviews.count).to_i
  end

  def average_flushing_power_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    reviews.average(:flushing_power).to_f
    # return reviews.sum(:star_rating).fdiv(reviews.count).to_i
  end

  def average_ambience_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    reviews.average(:ambience).to_f
    # return reviews.sum(:star_rating).fdiv(reviews.count).to_i
  end

  def average_toilet_paper_soap_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    reviews.average(:toilet_paper_soap).to_f
    # return reviews.sum(:star_rating).fdiv(reviews.count).to_i
  end



  def average_rating
    # logic for calculating averages
    # return hash value for averages
  end

end
