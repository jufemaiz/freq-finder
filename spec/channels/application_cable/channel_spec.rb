# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Channel do
  it 'raises error' do
    expect { subject.new(nil, nil) }.to raise_error(ArgumentError)
  end
end
