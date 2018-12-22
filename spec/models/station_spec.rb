# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Station, type: :model do
  it 'has a valid factory' do
    # Check that the factory we created is valid
    expect(build(:station)).to be_valid
  end

  let(:attributes) do
    {
      title: 'A test title'
    }
  end

  let(:station) { create(:station, **attributes) }

  describe 'model validations' do
    # check that the title field received the right values
    it { expect(station).to allow_value(attributes[:title]).for(:title) }
    # ensure that the title is unique for each station
    it { expect(station).to validate_uniqueness_of(:title) }
  end

  describe 'model associations' do
    # ensure a station has many items
    it { expect(station).to have_many(:transmitters) }
  end
end
