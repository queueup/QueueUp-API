class CreateInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :interactions, id: :uuid do |t|
      t.belongs_to :game_profile, foreign_key: true, type: :uuid
      t.uuid :target_id
      t.boolean :liked

      t.timestamps
    end
  end
end
