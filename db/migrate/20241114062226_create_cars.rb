class CreateCars < ActiveRecord::Migration[7.2]
  def change
    create_table :cars do |t|
      t.string :make
      t.string :model
      t.string :trim
      t.integer :year
      t.integer :mileage
      t.decimal :price
      t.text :features

      t.timestamps
    end
  end
end
