# frozen_string_literal: true

# [ExtractTransformLoad]
#
# @since 20181222
# @author Joel Courtney <joel@aceteknologi.com>
class ExtractTransformLoad
  # @!group
  BASE_DIR = Rails.root.join('public', 'yaml')
  EXCLUDE_KEYS = %i[id station_id created_at updated_at].freeze
  # @!endgroup

  # @!group Class methods
  class << self
    # Exports the data
    #
    # @return [void]
    def export # rubocop:disable Metrics/AbcSize
      Station.all.map do |s|
        station = JSON.parse(s.to_json).symbolize_keys.except(*EXCLUDE_KEYS)
        station[:transmitters] = s.transmitters.order(frequency: :asc).all.map do |t|
          JSON.parse(t.to_json).symbolize_keys.except(*EXCLUDE_KEYS)
        end

        filename = s[:title].blank? ? 'null' : s[:title].downcase.gsub(/[^\da-z]/, '_')
        File.open(BASE_DIR.join("#{filename}.yml"), 'w+') { |w| w.write(station.to_yaml) }
      end
    end

    # Imports the data from the publicly available YAML files.
    #
    # @return [void]
    def load # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      Dir.entries(BASE_DIR) # rubocop:disable Metrics/BlockLength
         .reject { |f| File.directory?(File.join(BASE_DIR, f)) }
         .sort
         .each do |station_file|
        station_data = YAML.load_file(File.join(BASE_DIR, station_file))

        Rails.logger.info("Seeding: #{station_data[:title]}")

        station = Station.find_or_create_by(title: station_data[:title])

        station_data[:transmitters].each do |transmitter|
          t = Transmitter.find_or_initialize_by(
            band: transmitter[:band],
            area: transmitter[:area],
            callsign: transmitter[:callsign],
            frequency: transmitter[:frequency],
            purpose: transmitter[:purpose],
            polarisation: transmitter[:polarisation],
            antenna_height: transmitter[:antenna_height],
            antenna_pattern: transmitter[:antenna_pattern],
            maximum_erp: transmitter[:maximum_erp],
            maximum_cmf: transmitter[:maximum_cmf],
            power: transmitter[:power],
            technical_specification_number: transmitter[:technical_specification_number],
            license_number: transmitter[:license_number],
            site_id: transmitter[:site_id],
            site_name: transmitter[:site_name],
            zone: transmitter[:zone],
            easting: transmitter[:easting],
            northing: transmitter[:northing],
            lat: transmitter[:lat],
            lng: transmitter[:lng],
            state: transmitter[:state],
            bsl: transmitter[:bsl],
            license_area: transmitter[:license_area],
            license_id: transmitter[:license_id],
            operation_hours: transmitter[:operation_hours],
            status: transmitter[:status]
          )
          t.station = station
          t.save

          next if t.persisted?

          Rails.logger.info("Data: #{transmitter.inspect}")
          Rails.logger.info("Errors: #{t.errors.messages}")
        end
      end
    end
  end
  # @!endgroup
end
