# frozen_string_literal: true

# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

%w[
  bug-catcher
  must-protect-queueup
  community-member
  swiped-em-all
  superior-analyst
  popular-mate
  famous-mate
  le-translator
  brawler
  explorer
  gold-digger
  diamond-searcher
  reviewer
  guide
  lord
  the-mentor
].each_with_index do |key, index|
  Merit::Badge.create!(id: index + 1, name: key)
end
