# frozen_string_literal: true

class WelcomeEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    @user = User.find(user_id)
    return if @user.email.nil?
    Mailjet::Send.create(
      messages: [{
        'From' => { 'Email' => ENV['MAILJET_API_DEFAULT_FROM'], 'Name' => ENV['MAILJET_API_DEFAULT_FROM_TEXT'] },
        'To' => [{ 'Email' => @user.email }],
        'TemplateID'       => ENV['MAILJET_API_WELCOME_TEMP_ID'].to_i,
        'TemplateLanguage' => true,
        'Subject'          => 'Welcome to QueueUp ! 🎉'
      }]
    )
  end
end
