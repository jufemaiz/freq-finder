# frozen_string_literal: true

module Types
  # [Types::StationEdgeType]
  #
  # @since 20181223
  # @author Joel Courtney <joel@aceteknologi.com>
  class StationEdgeType < BaseEdge
    graphql_name 'StationEdgeType'

    node_type(Types::StationType)
  end
end
