# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# AdminUser.create!(email: "admin@mayo.com", password: "password", password_confirmation: "password") if Rails.env.development?

# db/seeds.rb

User.create!(name: "John Doe", email: "john@mayo.com", password: "password")
Category.create!(name: "SUV")
Category.create!(name: "Sedan")

car1 = Car.create!(make: "Toyota", model: "Corolla", trim: "LE", year: 2018, mileage: 50000, price: 18000)
car2 = Car.create!(make: "Honda", model: "Civic", trim: "EX", year: 2020, mileage: 30000, price: 22000)

car1.categories << Category.find_by(name: "Sedan")
car2.categories << Category.find_by(name: "Sedan")

puts "Seeding completed!"
