class CreatePriceHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :price_histories do |t|
      t.references :car, null: false, foreign_key: true
      t.date :date_recorded
      t.decimal :price

      t.timestamps
    end
  end
end
