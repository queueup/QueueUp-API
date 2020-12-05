class CreateGameProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :game_profiles, id: :uuid do |t|
      t.uuid :resource_id
      t.string :resource_type

      t.belongs_to :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
