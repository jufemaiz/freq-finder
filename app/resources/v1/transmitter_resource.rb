# frozen_string_literal: true

module V1
  # [V1::TransmitterResource]
  #
  # @since 20181221
  # @author Joel Courtney <joel@aceteknologi.com>
  class TransmitterResource < JSONAPI::Resource
    # @!group Relationships
    has_one :station
    # @!endgroup

    # @!group Attributes
    attributes :antenna_height, :antenna_pattern, :area, :band, :bsl, :callsign,
               :created_at, :easting, :frequency, :license_area, :license_id,
               :license_number, :maximum_cmf, :maximum_erp, :northing,
               :operation_hours, :polarisation, :power, :purpose, :site_id,
               :site_name, :state, :station_id, :status,
               :technical_specification_number, :updated_at, :zone
    attribute :gps_coordinates
    # @!endgroup

    # @!group Filters
    filter :location
    # @!endgroup

    # @!group Class Methods
    class << self
      # Override the filter approach to allow for near request
      #
      # @param [Array<Transmitter>] records
      # @param [String] filter
      # @param [String] value
      # @param [Hash] options
      # @return [Array<Transmitter>] .
      def apply_filter(records, filter, value, options = {})
        if filter.to_sym != :location || value.blank? ||
           !value.join(',').match(Location::LATLNG_PATTERN)
          return super(records, filter, value, options)
        end

        location = Geokit::LatLng.normalize(value)

        records.by_distance(origin: location)
      end
    end
    # @!endgroup

    # @!group Custom Attributes
    # Provides a geographical coordinate with the following format:
    #
    #     {
    #       "latitude": value,
    #       "longitude": value
    #     }
    #
    # @return [Hash]
    def gps_coordinates
      {
        latitude: @model.lat,
        longitude: @model.lng
      }
    end
    # @!endgroup
  end
end
