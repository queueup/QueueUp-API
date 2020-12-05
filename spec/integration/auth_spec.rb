# frozen_string_literal: true

require 'swagger_helper'

user_type = {
  type: :object,
  properties: {
    id: { type: :string, 'x-nullable': true },
    provider: { type: :string, 'x-nullable': true },
    uid: { type: :string, 'x-nullable': true },
    email: { type: :string, 'x-nullable': true },
    allow_password_change: { type: :boolean },
    created_at: { type: :string, 'x-nullable': true },
    updated_at: { type: :string, 'x-nullable': true },
    facebook_id: { type: :string, 'x-nullable': true },
    google_id: { type: :string, 'x-nullable': true },
    locales: { type: :array, items: { type: :string } },
    sash_id: { type: :string, 'x-nullable': true },
    level: { type: :number },
    favorite_badge: { type: :string }
  }
}

describe 'Authentication', swagger_doc: 'authentication/swagger.json' do
  path '/auth' do
    post 'Sign up user' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :registration,
                in: :body,
                type: :object,
                required: true,
                properties: {
                  email: { type: :string },
                  password: { type: :string },
                  password_confirmation: { type: :string },
                  confirm_success_url: { type: :string }
                },
                example: {
                  email: 'team@queueup.gg',
                  password: '12345678',
                  password_confirmation: '12345678'
                }

      response '200', 'User created' do
        let(:user) { build(:user) }
        let(:registration) do
          {
            email: user.email,
            password: user.password,
            password_confirmation: user.password
          }
        end

        schema type: :object,
               properties: {
                 status: { type: :string },
                 data: user_type
               },
               required: %w[status data]

        run_test!
      end

      response '422', 'Invalid request' do
        let(:user) { build(:user) }
        let(:registration) do
          {
            email: nil,
            password: user.password,
            password_confirmation: "#{user.password}#{user.password}"
          }
        end

        schema type: :object,
               properties: {
                 status: { type: :string },
                 data: user_type,
                 errors: {
                   oneOf: [
                     {
                       type: :array,
                       items: { type: :string },
                       'x-nullable': true
                     },
                     {
                       type: :object,
                       properties: {
                         email: {
                           type: :array,
                           items:  {
                             email: { type: :string },
                             full_messages: { type: :string }
                           }
                         }
                       }
                     }
                   ]
                 }
               },
               required: %w[status data errors]

        run_test!
      end
    end

    delete 'Destroy current user' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Access-Token',
                in: :header,
                required: true,
                description: "Session's Access-Token",
                type: :string
      parameter name: 'Token-Type',
                in: :header,
                required: true,
                description: "Session's Token-Type",
                type: :string
      parameter name: 'Client',
                in: :header,
                required: true,
                description: "Session's Client",
                type: :string
      parameter name: 'Expiry',
                in: :header,
                required: true,
                description: "Session's Expiry",
                type: :string
      parameter name: 'Uid',
                in: :header,
                required: true,
                description: "Session's Uid",
                type: :string

      response '200', 'User destroyed' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { auth_token['access-token'] }
        let(:'Token-Type') { auth_token['token-type'] }
        let(:Client) { auth_token['client'] }
        let(:Expiry) { auth_token['expiry'] }
        let(:Uid) { auth_token['uid'] }

        run_test!
      end
    end
  end

  path '/auth/sign_in' do
    post 'Sign in user' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :session,
                in: :body,
                required: true,
                type: :object,
                properties: {
                  email: { type: :string },
                  password: { type: :string }
                },
                example: {
                  email: 'team@queueup.gg',
                  password: '12345678'
                }

      response '200', 'User signed in' do
        let(:user) { create(:user) }
        let(:session) do
          {
            email: user.email,
            password: user.password
          }
        end

        schema type: :object,
               properties: {
                 data: user_type
               },
               required: %w[data]

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:session) do
          {
            email: build(:user).email,
            password: nil
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 errors: { type: :array, items: { type: :string } }
               },
               required: %w[success errors]

        run_test!
      end
    end
  end

  path '/auth/sign_out' do
    delete 'Sign out user' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Access-Token',
                in: :header,
                required: true,
                description: "Session's Access-Token",
                type: :string
      parameter name: 'Token-Type',
                in: :header,
                required: true,
                description: "Session's Token-Type",
                type: :string
      parameter name: 'Client',
                in: :header,
                required: true,
                description: "Session's Client",
                type: :string
      parameter name: 'Expiry',
                in: :header,
                required: true,
                description: "Session's Expiry",
                type: :string
      parameter name: 'Uid',
                in: :header,
                required: true,
                description: "Session's Uid",
                type: :string

      response '200', 'User signed out' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { auth_token['access-token'] }
        let(:'Token-Type') { auth_token['token-type'] }
        let(:Client) { auth_token['client'] }
        let(:Expiry) { auth_token['expiry'] }
        let(:Uid) { auth_token['uid'] }

        schema type: :object,
               properties: {
                 success: { type: :boolean }
               },
               required: %w[success]

        run_test!
      end

      response '404', 'Not found' do
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 errors: { type: :array, items: { type: :string } }
               },
               required: %w[success errors]

        run_test!
      end
    end
  end

  path '/auth/password' do
    post 'Request password reset email' do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :password,
                in: :body,
                required: true,
                type: :object,
                properties: {
                  email: { type: :string },
                  redirect_url: { type: :string }
                },
                example: {
                  email: 'team@queueup.gg',
                  redirect_url: 'https://queueup.gg/auth/reset_password'
                }

      response '200', 'Email sent' do
        let(:user) { create(:user) }
        let(:password) do
          {
            email: user.email,
            redirect_url: Faker::Internet.url
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 message: { type: :string }
               },
               required: %w[success message]

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user) { create(:user) }
        let(:password) do
          {
            email: user.email,
            redirect_url: nil
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 errors: { type: :array, items: { type: :string } }
               },
               required: %w[success errors]

        run_test!
      end

      response '404', 'User not found' do
        let(:user) { build(:user) }
        let(:password) do
          {
            email: user.email,
            redirect_url: Faker::Internet.url
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 errors: { type: :array, items: { type: :string } }
               },
               required: %w[success errors]

        run_test!
      end
    end

    patch "Update current user's password" do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'Access-Token',
                in: :header,
                required: true,
                description: "Session's Access-Token",
                type: :string
      parameter name: 'Token-Type',
                in: :header,
                required: true,
                description: "Session's Token-Type",
                type: :string
      parameter name: 'Client',
                in: :header,
                required: true,
                description: "Session's Client",
                type: :string
      parameter name: 'Expiry',
                in: :header,
                required: true,
                description: "Session's Expiry",
                type: :string
      parameter name: 'Uid',
                in: :header,
                required: true,
                description: "Session's Uid",
                type: :string
      parameter name: :password,
                in: :body,
                required: true,
                type: :object,
                properties: {
                  password: { type: :string },
                  password_confirmation: { type: :string }
                },
                example: {
                  password: '12345678',
                  password_confirmation: '12345678'
                }

      response '200', 'Password updated' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { auth_token['access-token'] }
        let(:'Token-Type') { auth_token['token-type'] }
        let(:Client) { auth_token['client'] }
        let(:Expiry) { auth_token['expiry'] }
        let(:Uid) { auth_token['uid'] }
        let(:new_user) { build(:user) }
        let(:password) do
          {
            password: new_user.password,
            password_confirmation: new_user.password
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 data: user_type,
                 message: { type: :string }
               },
               required: %w[success data message]

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { nil }
        let(:'Token-Type') { nil }
        let(:Client) { nil }
        let(:Expiry) { nil }
        let(:Uid) { nil }
        let(:new_user) { build(:user) }
        let(:password) { new_user.password }
        let(:password_confirmation) { new_user.password }

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 errors: { type: :array, items: { type: :string } }
               },
               required: %w[success errors]

        run_test!
      end

      response '422', 'Unprocessable entity' do
        let(:user) { create(:user) }
        let(:auth_token) { user.create_new_auth_token }
        let(:'Access-Token') { auth_token['access-token'] }
        let(:'Token-Type') { auth_token['token-type'] }
        let(:Client) { auth_token['client'] }
        let(:Expiry) { auth_token['expiry'] }
        let(:Uid) { auth_token['uid'] }
        let(:password) { '' }
        let(:password_confirmation) { '' }

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 errors: { type: :array, items: { type: :string } }
               },
               required: %w[success errors]

        run_test!
      end
    end
  end
end
