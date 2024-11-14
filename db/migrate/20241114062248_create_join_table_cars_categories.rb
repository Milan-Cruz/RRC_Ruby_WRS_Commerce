class CreateJoinTableCarsCategories < ActiveRecord::Migration[7.2]
  def change
    create_join_table :cars, :categories do |t|
      # t.index [:car_id, :category_id]
      # t.index [:category_id, :car_id]
    end
  end
end
