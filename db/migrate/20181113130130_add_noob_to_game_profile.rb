class AddNoobToGameProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :game_profiles, :noob, :boolean, default: false
    add_column :game_profiles, :name, :string, default: ''
    add_column :game_profiles, :avatar_url, :string, default: ''
  end
end
