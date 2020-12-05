class CreateGameProfileScores < ActiveRecord::Migration[5.1]
  def change
    create_table :game_profile_scores, id: :uuid do |t|
      t.belongs_to :game_profile, foreign_key: true, type: :uuid, index: true
      t.uuid :target_game_profile_id, foreign_key: true, index: true
      t.belongs_to :score, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
