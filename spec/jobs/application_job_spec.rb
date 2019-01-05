# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  before(:each) do
    ActiveJob::Base.queue_adapter = :test
  end

  it 'uses the "default" queue name' do
    expect(subject.queue_name).to eq('default')
  end
end
