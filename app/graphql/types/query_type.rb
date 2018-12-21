# frozen_string_literal: true

module Types
  # [Types::QueryType]
  #
  # @since 20181221
  # @author Joel Courtney <joel@aceteknologi.com>
  class QueryType < Types::BaseObject
    LATLNG_PATTERN = /^(-?\d+\.\d+),(-?\d+\.\d+)$/

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    description 'The query root of this schema'

    # First describe the field signature:
    field :station, Types::StationType, null: true do
      description 'Find a station by ID'
      argument :id, ID, required: true
    end

    field :stations, [Types::StationType], null: true do
      description 'All the stations'
    end

    # First describe the field signature:
    field :transmitter, Types::TransmitterType, null: true do
      description 'Find a transmitter by ID'
      argument :id, ID, required: true
    end

    field :transmitters, [Types::TransmitterType], null: true do
      description 'All the transmitters'
      argument :location, String, required: false
      argument :order_by, String, required: false # , default: 'frequency_ASC'
    end

    def station(id:)
      Station.find(id)
    end

    def stations
      Station.all
    end

    def transmitter(id:)
      Transmitter.find(id)
    end

    def transmitters(location:, order_by:)

      return Transmitter.all unless location && location.match(LATLNG_PATTERN)

      location = Geokit::LatLng.normalize(
        location.split(',')
      )

      Transmitter.by_distance(origin: location)
    end
  end
end
