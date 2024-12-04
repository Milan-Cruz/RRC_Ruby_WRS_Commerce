class CreateContacts < ActiveRecord::Migration[7.2]
  def change
    create_table :contacts do |t|
      t.string :address
      t.string :email
      t.string :phone
      t.text :opening_hours

      t.timestamps
    end
  end
end
