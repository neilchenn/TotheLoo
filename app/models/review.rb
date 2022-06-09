class Review < ApplicationRecord
  belongs_to :user
  belongs_to :loo
  # after_create :update_average_loo_rating

  # def update_average_loo_rating
  #   # do some calculation
  #   # loo.update_attributes(:field1 => loo.average_rating)
  # end
end
