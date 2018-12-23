# frozen_string_literal: true

module QueryTypes
  # [QueryTypes::TransmitterQueryType]
  #
  # @since 20181221
  # @author Joel Courtney <joel@aceteknologi.com>
  class TransmitterQueryType < GraphQL::Schema::Object
    graphql_name 'TransmitterQueryType'
    description 'The Transmitter Query Type'

    field :transmitters,
          [Types::TransmitterType.connection_type],
          null: true,
          description: 'returns all transmitters'

    def transmitters(_obj, _args, _ctx)
      Transmitter.all
    end
  end
end
