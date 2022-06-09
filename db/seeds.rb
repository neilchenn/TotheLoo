# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Loo.destroy_all && User.destroy_all

User.create!(
  email: 'admin@admin.com',
  password: 'secret'
)

require "open-uri"
require "json"

url = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=richmond&limit=50"

buffer = URI.open(url).read
data = JSON.parse(buffer)["result"]["records"]

data.each do |loo|
  Loo.create!(
    facility_type: loo["FacilityType"],
    name: loo["Name"],
    address: loo["Address1"] + " " + loo["Town"] + " "+ loo["State"],
    latitude: loo["Latitude"],
    longitude: loo["Longitude"],
    parking: loo["Parking"],
    accessible: loo["Accessible"],
    baby_change: loo["BabyChange"],
    male: loo["Male"],
    female: loo["Female"],
    unisex: loo["Unisex"],
    opening_hours: loo["OpeningHours"],
    user_id: User.first.id
  )
end

Loo.all.each do |loo|
  User.all.each do |user|
    review = Review.create!(
                        user: user,
                        loo: loo,
                        cleanliness: rand(0..5),
                        flushing_power: rand(0..5),
                        ambience: rand(0..5),
                        toilet_paper_soap: rand(0..5),
                        star_rating: rand(0..5))
  end
end
