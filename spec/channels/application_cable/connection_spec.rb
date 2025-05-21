# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCable::Connection do
  subject(:this) { described_class }

  it 'raise error' do
    expect { this.new(nil, nil) }.to raise_error(ArgumentError)
  end
end
