class AddScoresToGameProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :game_profiles, :scores, :json, default: {}
  end
end
