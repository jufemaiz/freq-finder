# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transmitter, type: :model do
  it 'has a valid factory' do
    # Check that the factory we created is valid
    expect(build(:transmitter)).to be_valid
  end

  let(:attributes) do
    {
      band: 'AM'
    }
  end

  let(:transmitter) { create(:transmitter, **attributes) }

  describe 'model validations' do
    # check that the :site_name field received the right values
    it { expect(transmitter).to allow_value(attributes[:site_name]).for(:site_name) }
    # ensure that the :site_name is unique for each transmitter
    it { expect(transmitter).to validate_uniqueness_of(:site_name) }
  end

  describe 'model associations' do
    # ensure a :transmitter belongs to a :station
    it { expect(transmitter).to belong_to(:station) }
  end
end
