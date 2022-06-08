class ChangeReviewColumnsToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :cleanliness, :decimal,  precision: 3, scale: 2
    change_column :reviews, :flushing_power, :decimal,  precision: 3, scale: 2
    change_column :reviews, :ambience, :decimal,  precision: 3, scale: 2
    change_column :reviews, :toilet_paper_soap, :decimal,  precision: 3, scale: 2
    change_column :reviews, :star_rating, :decimal,  precision: 3, scale: 2
  end
end
