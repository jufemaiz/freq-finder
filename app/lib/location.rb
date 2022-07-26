# frozen_string_literal: true

# [Location]
#
# @since 20181222
# @author Joel Courtney <joel@aceteknologi.com>
class Location < Geokit::LatLng
  # @!group Constants
  LATLNG_PATTERN = /^(-?\d+\.\d+),(-?\d+\.\d+)$/
  # @!endgroup

  # @!group Class methods
  class << self
    # Validates a known GPS string to check validity
    #
    # @param [String] location
    # @return [Boolean]
    def valid_gps?(location)
      return true if location.is_a?(Geokit::LatLng)
      return false unless location.is_a?(String)
      return false unless location.match(LATLNG_PATTERN)

      true
    end
  end
  # @!endgroup
end
