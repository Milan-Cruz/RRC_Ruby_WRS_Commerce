class CreateAbouts < ActiveRecord::Migration[7.2]
  def change
    create_table :abouts do |t|
      t.text :description

      t.timestamps
    end
  end
end
