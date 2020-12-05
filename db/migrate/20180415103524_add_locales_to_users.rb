class AddLocalesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :locales, :text, array: true, default: []
  end
end
