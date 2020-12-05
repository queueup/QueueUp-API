class AddClearedSuggestionsAtToGameProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :game_profiles, :cleared_suggestions_at, :datetime, default: nil
  end
end
