# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location do
  describe '.valid_gps?' do
    let(:location) { nil }
    let(:latitude) { -33.8560 }
    let(:longitude) { 151.2067 }

    context 'with a Geokit::LatLng' do
      let(:location) { Geokit::LatLng.normalize(latitude, longitude) }

      it { expect(described_class.valid_gps?(location)).to be(true) }
    end

    context 'with a valid String' do
      let(:location) { [latitude, longitude].join(',') }

      it { expect(described_class.valid_gps?(location)).to be(true) }
    end

    context 'with an invalid String' do
      let(:location) { [latitude, longitude].join('BLAH') }

      it { expect(described_class.valid_gps?(location)).to be(false) }
    end

    context 'with an invalid argument' do
      let(:location) { { a: 'b' } }

      it { expect(described_class.valid_gps?(location)).to be(false) }
    end
  end
end
