class AddCustomFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :impersonating, :string
  end
end
