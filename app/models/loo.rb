class Loo < ApplicationRecord
  acts_as_favoritable
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :address, presence: true
  validate :address_geolocation
  validates :latitude, presence: true
  validates :longitude, presence: true
  before_save :capitalize_name, :capitalize_address

  geocoded_by :address
  before_validation :geocode, if: :will_save_change_to_address?

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
    reviews.average(:cleanliness).round.to_i
    # return reviews.sum).fdiv(reviews.count).to_i
  end

  def average_flushing_power_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    reviews.average(:flushing_power).round.to_i
    # return reviews.sum(:star_rating).fdiv(reviews.count).to_i
  end

  def average_ambience_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    reviews.average(:ambience).round.to_i
    # return reviews.sum(:star_rating).fdiv(reviews.count).to_i
  end

  def average_toilet_paper_soap_rating
    # return nil if no reviews
    return nil if reviews.empty?
    # loop through and grab average
    reviews.average(:toilet_paper_soap).round.to_i
    # return reviews.sum(:star_rating).fdiv(reviews.count).to_i
  end

  def capitalize_name
    self.name = self.name.split.collect(&:capitalize).join(' ') if self.name && !self.name.blank?
  end

  def capitalize_address
    self.address = self.address.split.collect(&:capitalize).join(' ') if self.address && !self.address.blank?
  end

  private

  def address_geolocation
    errors.add(:address, "is not valid") unless geocoded?
    errors.add(:address, "is already taken") if Loo.where(longitude: longitude).and(Loo.where(latitude: latitude)).exists?
  end

end
