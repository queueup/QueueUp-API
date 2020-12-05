# frozen_string_literal: true

Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :v1 do
    resources :badges, only: %i[index show]

    resources :devices, except: :update

    resources :fortnite_profiles, except: :index do
      get :by_handle, on: :member
      patch :reload, on: :member
    end

    resources :game_profiles, only: %i[index show destroy]
    resources :game_profile_reports, only: :create
    resources :game_profile_scores

    resources :interactions, only: :create

    get 'league_of_legends_profiles/:region/:summoner_name', to: 'league_of_legends_profiles#by_summoner'
    resources :league_of_legends_profiles, except: :index do
      patch :reload, on: :member
    end

    post 'omniauth/facebook', to: 'omniauth#facebook'
    post 'omniauth/google', to: 'omniauth#google'

    resources :matches, except: %i[create update]
    resources :match_memberships, only: %i[index show] do
      patch :messages_read_at, on: :member
    end

    resources :messages, only: %i[index show create]

    resources :scores, only: %i[index show]

    resources :suggestions, only: :index

    resource :user, only: %i[show update]
  end

  namespace :fortnite do
    resources :assets, only: [] do
      get :avatars, on: :collection
    end
  end

  namespace :league_of_legends do
    resources :champions, only: :index
  end

  resources :status, only: :index

  if ENV['SIDEKIQ_WEB'].present?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  if ENV['SWAGGER_WEB'].present?
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end
end
