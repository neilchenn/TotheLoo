class ChangeScaleOnReviews < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :cleanliness, :integer
    change_column :reviews, :flushing_power, :integer
    change_column :reviews, :ambience, :integer
    change_column :reviews, :toilet_paper_soap, :integer
    change_column :reviews, :star_rating, :integer
  end
end
