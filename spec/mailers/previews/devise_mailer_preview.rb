# frozen_string_literal: true

module Devise
  class MailerPreview < ActionMailer::Preview
    # def confirmation_instructions
    #   Devise::Mailer.confirmation_instructions(User.first, "faketoken")
    # end

    # http://localhost:3000/rails/mailers/devise/mailer/reset_password_instructions
    def reset_password_instructions
      Devise::Mailer.reset_password_instructions(User.new(email: 'team@queueup.gg'), 'token')
    end
  end
end
