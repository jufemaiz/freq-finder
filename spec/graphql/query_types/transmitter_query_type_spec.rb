# frozen_string_literal: true

RSpec.describe QueryTypes::TransmitterQueryType do
  set_graphql_type

  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance
  # create fake {Transmitter}s using the {Transmitter} factory
  let!(:transmitters) { create_list(:transmitter, 3) }

  describe 'querying all transmitters' do
    it 'has a :transmitters that returns a Types::TransmitterType' do
      expect(subject).to have_field(:transmitters).that_returns(types[Types::TransmitterConnectionType])
    end

    it 'returns all our created transmitters' do
      query_result = subject.fields['transmitters'].resolve(nil, nil, nil)

      query_result_array = query_result.to_a

      # ensure that each of our transmitters is returned
      transmitters.each do |transmitter|
        expect(query_result_array).to include(transmitter)
      end

      # we can also check that the number of lists returned is the one we created.
      expect(query_result.count).to eq(transmitters.count)
    end
  end
end
