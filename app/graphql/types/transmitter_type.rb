# frozen_string_literal: true

module Types
  # [Types::TransmitterType]
  #
  # @since 20181220
  # @author Joel Courtney <joel@aceteknologi.com>
  class TransmitterType < Types::BaseObject
    graphql_name 'TransmitterType'
    description 'The Transmitter'

    field :id, ID, null: false, description: 'id of the transmitter'
    field :station, Types::StationType, null: false, description: 'station of the transmitter'

    field :antenna_height, Integer, null: false, description: 'antenna_height of the transmitter'
    field :antenna_pattern, String, null: false, description: 'antenna pattern of the transmitter' # rubocop:disable GraphQL/ExtractType
    field :area, String, null: false, description: 'area of the transmitter'
    field :band, String, null: false, description: 'band of the transmitter'
    field :bsl, Integer, null: false, description: 'bsl of the transmitter'
    field :callsign, String, null: false, description: 'callsign of the transmitter'
    field :easting, Integer, null: false, description: 'easting of the transmitter'
    field :frequency, Float, null: false, description: 'frequency of the transmitter'
    field :lat, Float, null: false, description: 'lat of the transmitter'
    field :license_area, String, null: false, description: 'license_area of the transmitter'
    field :license_id, Integer, null: false, description: 'license_id of the transmitter'
    field :license_number, Integer, null: false, description: 'license number of the transmitter' # rubocop:disable GraphQL/ExtractType
    field :lng, Float, null: false, description: 'lng of the transmitter'
    field :maximum_cmf, Integer, null: false, description: 'maximum cmf of the transmitter'
    field :maximum_erp, Integer, null: false, description: 'maximum erp of the transmitter' # rubocop:disable GraphQL/ExtractType
    field :northing, Integer, null: false, description: 'northing of the transmitter'
    field :operation_hours, String, null: false, description: 'operation hours of the transmitter'
    field :polarisation, String, null: false, description: 'polarisation of the transmitter'
    field :power, Integer, null: false, description: 'power of the transmitter'
    field :purpose, String, null: false, description: 'purpose of the transmitter'
    field :site_id, Integer, null: false, description: 'site id of the transmitter'
    field :site_name, String, null: false, description: 'site name of the transmitter' # rubocop:disable GraphQL/ExtractType
    field :state, String, null: false, description: 'state of the transmitter'
    field :status, String, null: false, description: 'status of the transmitter'
    field :technical_specification_number, Integer, null: false, description: 'Technical specification number of the transmitter'
    field :zone, Integer, null: false, description: 'Zone of the transmitter'

    field :distance, Float, null: true, extras: [:parent], description: 'Distance of the transmitter to the ?'

    # Distance is used to calculate the value for the field :distance.
    #
    # @param [Object] parent
    # @return [Numeric]
    def distance(parent:) # rubocop:disable GraphQL/ResolverMethodLength
      # There are options on obtaining the location
      ancestor = parent
      location = nil

      loop do
        break if ancestor.nil?

        args = arguments(object: ancestor)

        unless args.nil? || args[:location].nil?
          location = args[:location]
          break
        end

        ancestor = ancestor.parent
      end

      return nil if location.nil? || !Location.valid_gps?(location)

      Location.normalize(location).distance_to(object.location, units: :meters)
    end

    # Returns the arguments for an object.
    #
    # @param [GraphQL::Pagination::Connection::Edge] object
    # @return [Hash]
    def arguments(object:)
      connection = object.instance_variable_get(:@connection)
      return {} if connection.nil?

      connection.instance_variable_get(:@arguments) || {}
    end
  end
end
