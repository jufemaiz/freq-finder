# frozen_string_literal: true

RSpec.describe QueryTypes::StationQueryType do
  set_graphql_type

  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance
  # create fake stations using the {Station} factory
  let!(:stations) { create_list(:station, 3) }

  describe 'querying all stations' do
    it 'has a :stations that returns a Types::StationType' do
      expect(subject).to have_field(:stations).that_returns(types[Types::StationConnectionType])
    end

    it 'returns all our created stations' do
      query_result = subject.fields['stations'].resolve(nil, nil, nil)

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
