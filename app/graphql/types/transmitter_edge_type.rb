# frozen_string_literal: true

module Types
  # [Types::TransmitterEdgeType]
  #
  # @since 20181223
  # @author Joel Courtney <joel@aceteknologi.com>
  class TransmitterEdgeType < BaseEdge
    graphql_name 'TransmitterEdgeType'

    node_type(Types::TransmitterType)
  end
end
