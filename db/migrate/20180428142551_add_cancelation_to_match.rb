class AddCancelationToMatch < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :canceled_at, :datetime, default: nil
  end
end
