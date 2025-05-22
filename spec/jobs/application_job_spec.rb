# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob do
  subject(:this) { described_class }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  it 'uses the "default" queue name' do
    expect(this.queue_name).to eq('default')
  end
end
