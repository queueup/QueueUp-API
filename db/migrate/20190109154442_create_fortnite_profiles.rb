class CreateFortniteProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :fortnite_profiles, id: :uuid do |t|
      t.string :player_id
      t.string :platform
      t.string :picture_url
      t.string :handle
      t.string :description
      t.boolean :duo
      t.boolean :squad
      t.boolean :fun
      t.boolean :try_hard
      t.integer :kills_solo
      t.integer :kills_duo
      t.integer :kills_squad
      t.float :kd_solo
      t.float :kd_duo
      t.float :kd_squad
      t.integer :played_solo
      t.integer :played_duo
      t.integer :played_squad
      t.datetime :scout_updated_at

      t.timestamps
    end
  end
end
