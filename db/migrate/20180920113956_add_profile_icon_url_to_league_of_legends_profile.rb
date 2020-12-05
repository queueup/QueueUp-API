class AddProfileIconUrlToLeagueOfLegendsProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :league_of_legends_profiles,
    :profile_icon_url,
    :string,
    default: 'https://ddragon.leagueoflegends.com/cdn/8.18.2/img/profileicon/0.png'
  end
end
