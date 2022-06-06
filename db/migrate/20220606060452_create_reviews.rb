class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :loo, null: false, foreign_key: true
      t.integer :cleanliness
      t.integer :flushing_power
      t.integer :ambience
      t.integer :toilet_paper_soap
      t.string :report_a_problem

      t.timestamps
    end
  end
end
