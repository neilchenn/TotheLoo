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

5.times do |index|
  User.create!(
    email: "user#{index + 1}@user.com",
    password: 'secret'
  )
end

require "open-uri"
require "json"

url_richmond = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=richmond&limit=20"

buffer_richmond = URI.open(url_richmond).read
data_richmond = JSON.parse(buffer_richmond)["result"]["records"]

data_richmond.each do |loo|
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

url_melbourne = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=melbourne&limit=20"

buffer_melbourne = URI.open(url_melbourne).read
data_melbourne = JSON.parse(buffer_melbourne)["result"]["records"]

data_melbourne.each do |loo|
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

url_barham = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=barham&limit=20"

buffer_barham = URI.open(url_barham).read
data_barham = JSON.parse(buffer_barham)["result"]["records"]

data_barham.each do |loo|
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


url_cockatoo = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=cockatoo&limit=20"

buffer_cockatoo = URI.open(url_cockatoo).read
data_cockatoo = JSON.parse(buffer_cockatoo)["result"]["records"]

data_cockatoo.each do |loo|
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
              cleanliness: rand(0..9),
              flushing_power: rand(0..9),
              ambience: rand(0..9),
              toilet_paper_soap: rand(0..9),
              star_rating: rand(0..9))
  end
end
