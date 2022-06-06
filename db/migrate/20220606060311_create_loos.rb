class CreateLoos < ActiveRecord::Migration[6.1]
  def change
    create_table :loos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :facility_type
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :parking
      t.boolean :accessible
      t.boolean :baby_change
      t.boolean :male
      t.boolean :female
      t.boolean :unisex
      t.string :opening_hours

      t.timestamps
    end
  end
end
