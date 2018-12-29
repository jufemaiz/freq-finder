# frozen_string_literal: true

RSpec.describe QueryTypes::StationQueryType do
  # create fake stations using the {Station} factory
  let!(:stations) { create_list(:station, 3) }

  describe 'querying all stations' do
    it 'has a :stations field that is type `Types::StationConnectionType`' do
      expect(described_class.fields['stations'].type)
        .to eq(Types::StationConnectionType)
    end

    it 'returns all our created stations' do
      query_result = described_class.fields['stations'].resolve(nil, nil, nil)

      query_result_array = query_result.to_a

      # ensure that each of our stations is returned
      stations.each do |station|
        expect(query_result_array).to include(station)
      end

      # we can also check that the number of lists returned is the one we created.
      expect(query_result.count).to eq(stations.count)
    end
  end
end
