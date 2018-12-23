# frozen_string_literal: true

module Types
  # [Types::StationType]
  #
  # @since 20181220
  # @author Joel Courtney <joel@aceteknologi.com>
  class StationType < Types::BaseObject
    graphql_name 'StationType'
    description 'The Station'

    field :id, ID, null: false
    field :title, String, null: false
    field :transmitters,
          TransmitterConnectionType,
          null: true,
          connection: true,
          description: 'The Transmitters that this station is responsible for.' do
      argument :location, String, required: false
    end

    # Returns the appropriate transmitters
    #
    # @return [Array<Transmitter>, Transmitter::ActiveRecord_Relation]
    def transmitters(location: nil)
      object.transmitters.by_distance_with_backup_sort(location)
    end
  end
end
