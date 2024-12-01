class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces do |t|
      t.string :name, null: false
      t.decimal :gst, precision: 5, scale: 2, default: 0.0
      t.decimal :pst, precision: 5, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
