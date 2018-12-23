# frozen_string_literal: true

module Types
  # [Types::StationConnectionType]
  #
  # @since 20181223
  # @author Joel Courtney <joel@aceteknologi.com>
  class StationConnectionType < BaseConnection
    graphql_name 'StationConnectionType'

    edge_type(Types::StationEdgeType)
  end
end
