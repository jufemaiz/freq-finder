# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location do
  describe '.valid_gps?' do
    let(:location) { nil }
    let(:latitude) { -33.8560 }
    let(:longitude) { 151.2067 }

    context 'with a Geokit::LatLng' do
      let(:location) { Geokit::LatLng.normalize(latitude, longitude) }

      it { expect(Location.valid_gps?(location)).to eq(true) }
    end

    context 'with a valid String' do
      let(:location) { [latitude, longitude].join(',') }

      it { expect(Location.valid_gps?(location)).to eq(true) }
    end

    context 'with an invalid String' do
      let(:location) { [latitude, longitude].join('BLAH') }

      it { expect(Location.valid_gps?(location)).to eq(false) }
    end

    context 'with an invalid argument' do
      let(:location) { { a: 'b' } }

      it { expect(Location.valid_gps?(location)).to eq(false) }
    end
  end
end
