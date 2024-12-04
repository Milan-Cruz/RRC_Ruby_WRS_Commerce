require "faker"

# Seed Provinces
provinces = [
  { name: "Alberta", gst: 0.05, pst: 0.00 },
  { name: "British Columbia", gst: 0.05, pst: 0.07 },
  { name: "Manitoba", gst: 0.05, pst: 0.08 },
  { name: "New Brunswick", gst: 0.05, pst: 0.10 },
  { name: "Newfoundland and Labrador", gst: 0.05, pst: 0.10 },
  { name: "Nova Scotia", gst: 0.05, pst: 0.10 },
  { name: "Ontario", gst: 0.05, pst: 0.08 },
  { name: "Prince Edward Island", gst: 0.05, pst: 0.10 },
  { name: "Quebec", gst: 0.05, pst: 0.09975 },
  { name: "Saskatchewan", gst: 0.05, pst: 0.06 },
  { name: "Northwest Territories", gst: 0.05, pst: 0.00 },
  { name: "Nunavut", gst: 0.05, pst: 0.00 },
  { name: "Yukon", gst: 0.05, pst: 0.00 },
]

provinces.each do |province|
  Province.find_or_create_by!(name: province[:name]) do |prov|
    prov.gst = province[:gst]
    prov.pst = province[:pst]
  end
end

# Seed Categories
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

# Seed Admin User
AdminUser.create!(email: "admin@mayo.com", password: "password", password_confirmation: "password") if Rails.env.development?

# Seed Regular Users
provinces = Province.all

User.find_or_create_by!(email: "john@mayo.com") do |user|
  user.name = "John Doe"
  user.password = "password"
  user.address = "123 Maple Street"
  user.city = "Winnipeg"
  user.postal_code = "R3C 1A1"
  user.province_id = provinces.sample.id
end

# Create 6 additional users
6.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    postal_code: Faker::Address.zip_code,
    province_id: provinces.sample.id,
  )
end

# Seed Cars
categories = Category.all

300.times do
  car = Car.create!(
    make: Faker::Vehicle.make,
    model: Faker::Vehicle.model,
    trim: Faker::Vehicle.car_type,
    year: Faker::Vehicle.year,
    mileage: Faker::Number.between(from: 10_000, to: 200_000),
    price: Faker::Commerce.price(range: 5000..80_000),
    features: Faker::Vehicle.standard_specs.join(", "),
  )

  # Assign each car to one or more random categories
  categories.sample(rand(1..3)).each do |category|
    car.categories << category
  end
end

# Seed Orders
users = User.all
cars = Car.all

17.times do
  user = users.sample
  province = user.province
  gst = province.gst
  pst = province.pst

  # Create an order
  order = Order.create!(
    user: user,
    status: ["new", "paid", "shipped"].sample,
    total_price: 0, # Will calculate below
  )

  # Add random cars to the order
  total_price = 0
  rand(1..5).times do
    car = cars.sample
    quantity = rand(1..3)
    price_at_purchase = car.price

    OrderItem.create!(
      order: order,
      car: car,
      price_at_purchase: price_at_purchase,
      quantity: quantity,
    )

    total_price += price_at_purchase * quantity
  end

  # Calculate taxes and update total_price
  gst_amount = total_price * gst
  pst_amount = total_price * pst
  order.update!(total_price: total_price + gst_amount + pst_amount)
end

# Seed About Page
About.find_or_create_by!(description: <<~ABOUT
                           Business Description:
                           WRS Garage is a Winnipeg-based business with 10 employees that has been operating for over five years. 
                           The company specializes in sourcing and selling used cars with specific trim levels, options, and features that match buyer preferences, 
                           including amenities like sunroofs, leather seats, and advanced safety features. 
                           Currently, they sell their vehicles through local classified ads and partner dealerships, aiming to expand their reach by providing an easy-to-use online marketplace.

                           Target Demographic:
                           Our primary audience consists of Winnipeg-based car enthusiasts and buyers aged 25-50 who have specific vehicle requirements in mind. 
                           These are customers looking for particular trims or features in used vehicles but who lack a centralized platform to compare options and get historical pricing insights.
                         ABOUT
)

# Seed Contact Page
Contact.find_or_create_by!(
  address: "123 Main Street, Winnipeg, MB, Canada",
  email: "contact@wrsgarage.com",
  phone: "+1-204-555-1234",
  opening_hours: <<~HOURS
    Monday to Friday: 9:00 AM - 5:00 PM
    Saturday: 10:00 AM - 3:00 PM
    Sunday: Closed
  HOURS
)

puts "Seeding completed!"
