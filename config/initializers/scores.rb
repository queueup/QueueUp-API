# frozen_string_literal: true

return unless ActiveRecord::Base.connection.table_exists? :scores

[
  {
    key: 'friendly',
    positive: true
  },
  {
    key: 'team-leader',
    positive: true
  },
  {
    key: 'good-teammate',
    positive: true
  },
  {
    key: 'toxic',
    positive: false
  },
  {
    key: 'flamer',
    positive: false
  },
  {
    key: 'leaver',
    positive: false
  }
].each do |score|
  Score.where(score).first_or_create
end
