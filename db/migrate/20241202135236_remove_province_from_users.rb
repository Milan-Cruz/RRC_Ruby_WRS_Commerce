class RemoveProvinceFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :province, :string
  end
end