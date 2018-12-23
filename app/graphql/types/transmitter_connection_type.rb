# frozen_string_literal: true

module Types
  # [Types::TransmitterConnectionType]
  #
  # @since 20181223
  # @author Joel Courtney <joel@aceteknologi.com>
  class TransmitterConnectionType < BaseConnection
    graphql_name 'TransmitterConnectionType'

    edge_type(Types::TransmitterEdgeType)
  end
end
