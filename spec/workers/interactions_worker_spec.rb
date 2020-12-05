# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InteractionsWorker, type: :worker do
  it 'enqueues worker' do
    expect do
      create(:interaction)
    end.to change(InteractionsWorker.jobs, :size).by(1)
  end
end
