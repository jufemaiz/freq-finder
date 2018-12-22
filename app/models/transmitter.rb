# frozen_string_literal: true

# [Transmitter]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class Transmitter < ApplicationRecord
  # @!group Acts
  acts_as_mappable default_units: :kms,
                   distance_field_name: :distance
  # @!endgroup

  # @!group Constants
  ANTENNA_PATTERNS = %w[DA OD].freeze
  BANDS = %w[AM FM].freeze
  OPERATION_HOURS = %w[day-time night-time].freeze
  POLARISATIONS = %w[H M V].freeze
  PURPOSES = [
    'Commercial',
    'Community',
    'HPON',
    'National',
    'Retransmission',
    's212 Retransmission'
  ].freeze
  STATES = %w[ACT NSW NT QLD SA TAS VIC WA].freeze
  STATUSES = ['Issued', 'Renewal Pending'].freeze
  # @!endgroup

  # @!group Relationships
  belongs_to :station
  # @!endgroup

  # @!group Validations
  validates :antenna_height, numericality: { greater_than_or_equal_to: 0 }
  validates :antenna_pattern, inclusion: { in: ANTENNA_PATTERNS }
  validates :area, length: { minimum: 1 }
  validates :band, inclusion: { in: BANDS }
  validates :bsl, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :callsign, length: { in: 3..7 }, allow_nil: true
  validates :easting, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :frequency, numericality: { greater_than_or_equal_to: 0 }
  validates :lat, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :license_area, length: { minimum: 1 }, allow_nil: true
  validates :license_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :license_number, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :maximum_cmf, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :maximum_erp, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :northing, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :operation_hours, inclusion: { in: OPERATION_HOURS }, allow_nil: true
  validates :polarisation, inclusion: { in: POLARISATIONS }
  validates :power, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :purpose, inclusion: { in: PURPOSES }
  validates :site_id, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :site_name, uniqueness: { case_sensitive: true, scope: :station }
  validates :state, inclusion: { in: STATES }
  validates :status, inclusion: { in: STATUSES }
  validates :technical_specification_number,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :zone, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  # @!endgroup

  # @!group Scopes
  scope :am, -> { where(band: 'AM') }
  scope :fm, -> { where(band: 'FM') }
  # @!endgroup

  # @!group Class Methods
  class << self
    # Special scope service
    #
    # @param [String] location
    # @param [Hash] backup_sort
    # @return [ActiveRecord::Quer]
    def by_distance_with_backup_sort(location = nil, backup_sort = { frequency: :desc })
      return order(backup_sort) unless Location.valid_gps?(location)

      location = Location.normalize(location)
      by_distance(origin: location)
    end
  end
  # @!endgroup

  # Returns a Location for the Transmitter
  #
  # @return [Location]
  def location
    Location.normalize([lat, lng])
  end
end
