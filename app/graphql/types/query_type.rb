# frozen_string_literal: true

module Types
  # [Types::QueryType]
  #
  # @since 20181221
  # @author Joel Courtney <joel@aceteknologi.com>
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    description 'The query root of this schema'

    # First describe the field signature:
    field :station,
          Types::StationType,
          null: true do
      description 'Find a station by ID'
      argument :id, ID, required: true, description: 'ID of the station'
    end

    field :stations,
          Types::StationConnectionType,
          null: true,
          connection: true do
      description 'List the stations'
    end

    # First describe the field signature:
    field :transmitter,
          Types::TransmitterType,
          null: true do
      description 'Find a transmitter by ID'
      argument :id, ID, required: true, description: 'ID of the transmitter'
      argument :location, String, required: false, description: 'location of the station'
    end

    field :transmitters,
          Types::TransmitterConnectionType,
          null: true,
          connection: true do
      description 'List the transmitters'
      argument :location, String, required: false, description: 'Location to sort the transmitters'
      argument :order_by, String, required: false, description: 'Order priority' # , default: 'frequency_ASC'
    end

    # Returns a single {Station}
    #
    # @param [Integer] id
    # @return [Station]
    def station(id:)
      Station.find(id)
    end

    # Returns all {Station}s
    #
    # @return [Array<Station>, Station::ActiveRecord_Relation]
    def stations
      Station.order(title: :asc).all
    end

    # Returns a {Transmitter}
    #
    # @param [Integer] id
    # @param [String] location comma separated GPS coordinate
    # @return [Transmitter]
    def transmitter(id:, location: nil)
      Transmitter.where(id:)
                 .by_distance_with_backup_sort(location)
                 .first
    end

    # Returns all {Transmitter}s
    #
    # @param [String] location comma separated GPS coordinate
    # @param [String] order_by
    # @return [Array<Transmitter>, Transmitter::ActiveRecord_Relation]
    def transmitters(location: nil, order_by: nil)
      Transmitter.by_distance_with_backup_sort(location, order_by)
    end
  end
end
