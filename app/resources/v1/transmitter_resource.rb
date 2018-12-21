# frozen_string_literal: true

module V1
  # [V1::TransmitterResource]
  #
  # @since 20181221
  # @author Joel Courtney <joel@aceteknologi.com>
  class TransmitterResource < JSONAPI::Resource
    # @!group Constants
    # Latitude & Longitude pattern for filter :near
    LATLNG_PATTERN = /^(-?\d+\.\d+),(-?\d+\.\d+)$/
    # @!endgroup

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
    filter :near
    # @!endgroup

    # @!group Class Methods
    class << self
      # Customise the sortable fields
      #
      # @params [Array<Symbol>] context
      # @return [Array<Symbol>]
      def sortable_fields(context)
        super(context)
      end

      # Override the filter approach to allow for near request
      #
      # @param [] .
      # @param [] .
      # @param [] .
      # @param [] .
      # @return [Array<Transmitter>] .
      def apply_filter(records, filter, value, options = {})
        if filter.to_sym != :near || value.blank? ||
          !value.join(',').match(LATLNG_PATTERN)
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
