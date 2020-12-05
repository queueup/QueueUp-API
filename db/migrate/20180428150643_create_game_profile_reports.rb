class CreateGameProfileReports < ActiveRecord::Migration[5.1]
  def change
    create_table :game_profile_reports, id: :uuid do |t|
      t.belongs_to :game_profile, foreign_key: true, type: :uuid
      t.references :target_profile, index: true, foreign_key: { to_table: :game_profiles }, type: :uuid
      t.integer :reason
      t.text :description

      t.timestamps
    end
  end
end
