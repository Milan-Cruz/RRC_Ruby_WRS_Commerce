class CreateSearches < ActiveRecord::Migration[7.2]
  def change
    create_table :searches do |t|
      t.references :user, null: false, foreign_key: true
      t.text :search_criteria

      t.timestamps
    end
  end
end
