class RemoveSaltPasswordFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :salt, :string
  end
end
