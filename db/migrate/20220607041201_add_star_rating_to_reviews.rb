class AddStarRatingToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :star_rating, :integer
  end
end
