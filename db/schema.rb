# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190406145356) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "badges_sashes", force: :cascade do |t|
    t.integer "badge_id"
    t.integer "sash_id"
    t.boolean "notified_user", default: false
    t.datetime "created_at"
    t.index ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
    t.index ["badge_id"], name: "index_badges_sashes_on_badge_id"
    t.index ["sash_id"], name: "index_badges_sashes_on_sash_id"
  end

  create_table "devices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "player_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "fortnite_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "player_id"
    t.string "platform"
    t.string "picture_url"
    t.string "handle"
    t.string "description"
    t.boolean "duo"
    t.boolean "squad"
    t.boolean "fun"
    t.boolean "try_hard"
    t.integer "kills_solo"
    t.integer "kills_duo"
    t.integer "kills_squad"
    t.float "kd_solo"
    t.float "kd_duo"
    t.float "kd_squad"
    t.integer "played_solo"
    t.integer "played_duo"
    t.integer "played_squad"
    t.datetime "scout_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_profile_reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_profile_id"
    t.uuid "target_profile_id"
    t.integer "reason"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_profile_id"], name: "index_game_profile_reports_on_game_profile_id"
    t.index ["target_profile_id"], name: "index_game_profile_reports_on_target_profile_id"
  end

  create_table "game_profile_scores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_profile_id"
    t.uuid "target_game_profile_id"
    t.uuid "score_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_profile_id"], name: "index_game_profile_scores_on_game_profile_id"
    t.index ["score_id"], name: "index_game_profile_scores_on_score_id"
    t.index ["target_game_profile_id"], name: "index_game_profile_scores_on_target_game_profile_id"
  end

  create_table "game_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "resource_id"
    t.string "resource_type"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "noob", default: false
    t.string "name", default: ""
    t.string "avatar_url", default: ""
    t.json "scores", default: {}
    t.datetime "connected_at"
    t.datetime "cleared_suggestions_at"
    t.index ["resource_id"], name: "index_game_profiles_on_resource_id"
    t.index ["resource_type"], name: "index_game_profiles_on_resource_type"
    t.index ["user_id"], name: "index_game_profiles_on_user_id"
  end

  create_table "interactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_profile_id"
    t.uuid "target_id"
    t.boolean "liked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_profile_id"], name: "index_interactions_on_game_profile_id"
  end

  create_table "league_of_legends_matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "game_id"
    t.string "platform_id"
    t.uuid "league_of_legends_profile_id"
    t.datetime "started_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_of_legends_profile_id"], name: "index_league_of_legends_matches_on_league_of_legends_profile_id"
  end

  create_table "league_of_legends_positions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "league_of_legends_profile_id"
    t.string "rank"
    t.string "queue_type"
    t.boolean "hot_streak"
    t.integer "wins"
    t.boolean "veteran"
    t.integer "losses"
    t.boolean "fresh_blood"
    t.string "league_id"
    t.string "player_or_team_name"
    t.boolean "inactive"
    t.string "player_or_team_id"
    t.string "league_name"
    t.string "tier"
    t.integer "league_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_of_legends_profile_id"], name: "index_lol_positions_on_lol_profile_id"
  end

  create_table "league_of_legends_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "summoner_name"
    t.string "summoner_id"
    t.string "region"
    t.text "champions", array: true
    t.text "roles", array: true
    t.integer "profile_icon_id"
    t.integer "summoner_level"
    t.text "description"
    t.datetime "riot_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "account_id"
    t.string "profile_icon_url", default: "https://ddragon.leagueoflegends.com/cdn/8.18.2/img/profileicon/0.png"
    t.index ["region"], name: "index_league_of_legends_profiles_on_region"
    t.index ["summoner_name"], name: "index_league_of_legends_profiles_on_summoner_name"
  end

  create_table "match_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "game_profile_id"
    t.uuid "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "messages_read_at"
    t.index ["game_profile_id"], name: "index_match_memberships_on_game_profile_id"
    t.index ["match_id"], name: "index_match_memberships_on_match_id"
  end

  create_table "matches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "canceled_at"
  end

  create_table "merit_actions", force: :cascade do |t|
    t.integer "user_id"
    t.string "action_method"
    t.integer "action_value"
    t.boolean "had_errors", default: false
    t.string "target_model"
    t.integer "target_id"
    t.text "target_data"
    t.boolean "processed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer "action_id"
    t.string "related_change_type"
    t.integer "related_change_id"
    t.string "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.bigint "score_id"
    t.integer "num_points", default: 0
    t.string "log"
    t.datetime "created_at"
    t.index ["score_id"], name: "index_merit_score_points_on_score_id"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.bigint "sash_id"
    t.string "category", default: "default"
    t.index ["sash_id"], name: "index_merit_scores_on_sash_id"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "content"
    t.uuid "game_profile_id"
    t.uuid "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_profile_id"], name: "index_messages_on_game_profile_id"
    t.index ["match_id"], name: "index_messages_on_match_id"
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key"
    t.boolean "positive", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_scores_on_key"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "facebook_id"
    t.string "google_id"
    t.text "locales", default: [], array: true
    t.integer "sash_id"
    t.integer "level", default: 0
    t.string "favorite_badge", default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "devices", "users"
  add_foreign_key "game_profile_reports", "game_profiles"
  add_foreign_key "game_profile_reports", "game_profiles", column: "target_profile_id"
  add_foreign_key "game_profile_scores", "game_profiles"
  add_foreign_key "game_profile_scores", "scores"
  add_foreign_key "game_profiles", "users"
  add_foreign_key "interactions", "game_profiles"
  add_foreign_key "league_of_legends_matches", "league_of_legends_profiles"
  add_foreign_key "league_of_legends_positions", "league_of_legends_profiles"
  add_foreign_key "match_memberships", "game_profiles"
  add_foreign_key "match_memberships", "matches"
  add_foreign_key "messages", "game_profiles"
  add_foreign_key "messages", "matches"
end
