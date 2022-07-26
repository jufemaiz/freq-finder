# frozen_string_literal: true

module Types
  # [Types::TransmitterType]
  #
  # @since 20181220
  # @author Joel Courtney <joel@aceteknologi.com>
  class TransmitterType < Types::BaseObject
    graphql_name 'TransmitterType'
    description 'The Transmitter'

    field :id, ID, null: false
    field :station, Types::StationType, null: false

    field :antenna_height, Integer, null: false
    field :antenna_pattern, String, null: false
    field :area, String, null: false
    field :band, String, null: false
    field :bsl, Integer, null: false
    field :callsign, String, null: false
    field :easting, Integer, null: false
    field :frequency, Float, null: false
    field :lat, Float, null: false
    field :license_area, String, null: false
    field :license_id, Integer, null: false
    field :license_number, Integer, null: false
    field :lng, Float, null: false
    field :maximum_cmf, Integer, null: false
    field :maximum_erp, Integer, null: false
    field :northing, Integer, null: false
    field :operation_hours, String, null: false
    field :polarisation, String, null: false
    field :power, Integer, null: false
    field :purpose, String, null: false
    field :site_id, Integer, null: false
    field :site_name, String, null: false
    field :state, String, null: false
    field :status, String, null: false
    field :technical_specification_number, Integer, null: false
    field :zone, Integer, null: false

    field :distance, Float, null: true, resolver_method: :distance, extras: [:parent]

    # Distance is used to calculate the value for the field :distance.
    #
    # @param [Object] parent
    # @return [Numeric]
    def distance(parent:)
      # There are options on obtaining the location
      ancestor = parent
      location = nil

      loop do
        break if ancestor.nil?

        if ancestor.arguments.respond_to?(:location)
          location = ancestor.arguments.location
          break
        end

        ancestor = ancestor.parent
      end

      return nil if location.nil? || !Location.valid_gps?(location)

      Location.normalize(location).distance_to(transmitter.location, units: :meters)
    end
  end
end
