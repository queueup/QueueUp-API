class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches, id: :uuid do |t|
      t.timestamps
    end
  end
end
