require "faker"

# Categories gen
categories = [
  "SUVs",
  "Sedans",
  "Trucks",
  "Hatchbacks",
  "Coupes",
  "Convertibles",
  "Electric Vehicles (EVs)",
  "Hybrid Cars",
  "Luxury Cars",
  "Off-Road",
  "Minivans",
  "Sports Cars",
]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

AdminUser.create!(email: "admin@mayo.com", password: "password", password_confirmation: "password") if Rails.env.development?

User.find_or_create_by!(email: "john@mayo.com") do |user|
  user.name = "John Doe"
  user.password = "password"
  user.address = "123 Maple Street"
  user.city = "Winnipeg"
  user.postal_code = "R3C 1A1"
  user.province = "Manitoba"
end
# Category.create!(name: "SUV")
# Category.create!(name: "Sedan")

# car1 = Car.create!(make: "Toyota", model: "Corolla", trim: "LE", year: 2018, mileage: 50000, price: 18000)
# car2 = Car.create!(make: "Honda", model: "Civic", trim: "EX", year: 2020, mileage: 30000, price: 22000)

# car1.categories << Category.find_by(name: "Sedan")
# car2.categories << Category.find_by(name: "Sedan")

categories = Category.all

300.times do
  car = Car.create(
    make: Faker::Vehicle.make,
    model: Faker::Vehicle.model,
    trim: Faker::Vehicle.car_type,
    year: Faker::Vehicle.year,
    mileage: Faker::Number.between(from: 10_000, to: 200_000),
    price: Faker::Commerce.price(range: 5000..80_000),
    features: Faker::Vehicle.standard_specs.join(", "),
  )

  # Adiciona cada carro a uma ou mais categorias aleatórias
  categories.sample(rand(1..3)).each do |category|
    car.categories << category
  end
end

puts "Seeding completed!"
