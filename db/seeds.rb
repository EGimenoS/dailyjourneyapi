# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seed users
100.times do
  User.create(
    email: Faker::Internet.free_email,
    name: Faker::Name.name,
    avatar: Faker::Avatar.image,
    password: 'test1234',
    password_confirmation: 'test1234'
  )
end

# seed travels around Valencia
500.times do
  origin_latitude = rand(39.16975..39.56975)
  origin_longitude = rand(-0.408723..-0.37639)
  destination_latitude = rand(39.16975..39.56975)
  destination_longitude = rand(-0.408723..-0.37639)
  origin_address = Geocoder.search([origin_latitude, origin_longitude]).first.address
  destination_address = Geocoder.search([destination_latitude, destination_longitude]).first.address
  Travel.create(
    departure_time: '08:30',
    owner_comment: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true),
    capacity: Faker::Number.between(from: 1, to: 4),
    owner_id: Faker::Number.between(from: 1, to: 100),
    origin_attributes: { address: origin_address, longitude: origin_longitude, latitude: origin_latitude },
    destination_attributes: { address: destination_address, longitude: destination_longitude, latitude: destination_latitude },
    periodicity: 'Entre Semana'
  )
end
