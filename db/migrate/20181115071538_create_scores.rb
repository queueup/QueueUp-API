class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores, id: :uuid do |t|
      t.string :key, index: true
      t.boolean :positive, default: true

      t.timestamps
    end
  end
end
