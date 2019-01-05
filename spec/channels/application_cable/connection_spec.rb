# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Connection do
  it 'raise error' do
    expect { subject.new(nil, nil) }.to raise_error(ArgumentError)
  end
end
