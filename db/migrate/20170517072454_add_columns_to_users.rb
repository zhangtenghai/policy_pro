class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :province, :string
    add_column :users, :city, :string
    add_column :users, :district, :string
    add_column :users, :street, :string
  end
end
