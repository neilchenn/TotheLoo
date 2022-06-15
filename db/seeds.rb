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

url_richmond = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=VIC&q=richmond"

buffer_richmond = URI.open(url_richmond).read
data_richmond = JSON.parse(buffer_richmond)["result"]["records"]

data_richmond.each do |loo|
  Loo.create(
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

url_melbourne = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=VIC&q=melbourne"

buffer_melbourne = URI.open(url_melbourne).read
data_melbourne = JSON.parse(buffer_melbourne)["result"]["records"]

data_melbourne.each do |loo|
  Loo.create(
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

url_cremorne = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=VIC&q=cremorne"

buffer_cremorne = URI.open(url_cremorne).read
data_cremorne = JSON.parse(buffer_cremorne)["result"]["records"]

data_cremorne.each do |loo|
  Loo.create(
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


url_south_yarra = "https://data.gov.au/data/api/3/action/datastore_search?resource_id=34076296-6692-4e30-b627-67b7c4eb1027&q=VIC&q=south%20yarra"

buffer_south_yarra = URI.open(url_south_yarra).read
data_south_yarra = JSON.parse(buffer_south_yarra)["result"]["records"]

data_south_yarra.each do |loo|
  Loo.create(
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
