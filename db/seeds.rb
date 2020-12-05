%w[
  Sarcastique
  Teazie
  Zerp357
  remi5151
  NightSorrow69
  DerpDaddy
  Clorces
].each do |summoner|
  user = User.create!(
    email:    "#{summoner}@queueup.gg".downcase,
    password: '12345678',
    locales:  %w[fr-FR en-CA en-GB en-US].sample(rand(1..3))
  )

  profile = LeagueOfLegendsProfile.custom_find_by_summoner('euw', summoner)
  profile.user_id = user.id
  profile.save!

  GameProfile.create!(resource: profile, user: user)

  puts "Created #{user[:email]}"
end

u = User.order(:created_at).first

GameProfile.first(5).each do |gp|
  if gp != u.game_profiles.first
    m = Match.create
    MatchMembership.create!(game_profile: u.game_profiles.first, match: m)
    MatchMembership.create!(game_profile: gp, match: m)
  end
end
