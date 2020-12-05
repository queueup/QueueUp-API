# frozen_string_literal: true

class User < ApplicationRecord
  has_merit

  devise :database_authenticatable, :registerable, :recoverable
  include DeviseTokenAuth::Concerns::User

  after_create :send_welcome_email

  has_many :devices, dependent: :destroy
  has_many :game_profiles, dependent: :destroy
  has_many :match_memberships, through: :game_profiles
  has_many :interactions, through: :game_profiles
  has_many :matches, through: :match_memberships
  has_many :all_matched_profiles, through: :matches, source: :game_profiles
  has_many :messages, through: :matches
  has_many :game_profile_scores, through: :game_profiles
  has_many :received_game_profile_scores, through: :game_profiles

  validates :facebook_id, uniqueness: true, allow_nil: true
  validates :google_id, uniqueness: true, allow_nil: true
  validate :favorite_badge_check

  def self.facebook(access_token, current_user = nil)
    facebook = Koala::Facebook::API.new(access_token)
    params = facebook.get_object('me')

    if current_user.nil?
      user = User.where(facebook_id: params['id']).or(User.where(email: params['email'])).first_or_initialize
      user.uid = params['id']
      user.email = params['email']
      user.provider = :facebook
      return user
    else
      current_user.facebook_id = params['id']
    end
  end

  def self.google(id_token, current_user = nil)
    response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?id_token=#{id_token}")

    return User.new unless response.success?

    if current_user.nil?
      email = response.parsed_response['email']
      user = User.where(google_id: email).or(User.where(email: email)).first_or_initialize
      user.uid = email
      user.email = email
      user.provider = :google
      return user
    else
      current_user.google_id = params['id']
    end
  end

  def matched_profiles
    all_matched_profiles.distinct.where.not(id: game_profile_ids)
  end

  private

  def send_welcome_email
    WelcomeEmailWorker.perform_async(id)
  end

  def favorite_badge_check
    return unless !favorite_badge.empty? && (Merit::Badge.by_name(favorite_badge).map(&:name) & badges.map(&:name)).empty?

    errors.add(:favorite_badge, :not_acquired)
  end
end
