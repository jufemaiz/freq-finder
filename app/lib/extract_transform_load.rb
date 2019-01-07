# frozen_string_literal: true

# [ExtractTransformLoad]
#
# @since 20181222
# @author Joel Courtney <joel@aceteknologi.com>
class ExtractTransformLoad
  # @!group
  BASE_DIR = Rails.root.join('public', 'yaml')
  EXCLUDE_KEYS = %i[id station_id created_at updated_at].freeze
  EXPORT_SUBDIR = '%Y%m%dT%H%M%SZ'
  # @!endgroup

  # @!group Class methods
  class << self
    def export_subdirectory
      Time.now.utc.strftime(EXPORT_SUBDIR)
    end

    # Exports the data to an RFC3337 subdirectory of the export directory.
    #
    # @return [void]
    def export! # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      export_path = BASE_DIR.join(export_subdirectory)
      FileUtils.mkdir_p(export_path)

      Station.all.map do |s|
        station = JSON.parse(s.to_json).symbolize_keys.except(*EXCLUDE_KEYS)
        station[:transmitters] = s.transmitters.order(frequency: :asc).all.map do |t|
          JSON.parse(t.to_json).symbolize_keys.except(*EXCLUDE_KEYS)
        end

        filename = s[:title].blank? ? 'null' : s[:title].downcase.gsub(/[^\da-z]/, '_')
        File.open(export_path.join("#{filename}.yml"), 'w+') { |w| w.write(station.to_yaml) }
        Rails.logger.info("Exported transmitters for #{s.title} (id: #{s.id})")
      end
    end

    # Imports the data from the publicly available YAML files.
    #
    # @param [String] subdirectory explicitly provide a subdirectory
    # @return [void]
    def import!(subdirectory = nil) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      path = import_path_for(subdirectory)

      import_files(path).each do |station_file|
        station_data = YAML.load_file(station_file)

        Rails.logger.info("Importing details for #{station_data[:title]}")

        station = Station.find_or_create_by(title: station_data[:title])

        station_data[:transmitters].each do |transmitter|
          transmitter = transmitter.reject { |k, _v| EXCLUDE_KEYS.include?(k) }
          t = Transmitter.find_or_initialize_by(transmitter)
          t.station = station
          t.save

          next if t.persisted?

          Rails.logger.info("Data: #{transmitter.inspect}\nErrors: #{t.errors.messages}")
        end

        transmitter_count = Transmitter.where(station: station).count
        Rails.logger.info(
          "Imported #{transmitter_count} transmitters for #{station.title} (id: #{station.id})"
        )
      end
    end

    private

    # Array of paths to files to be imported
    #
    # @param [Pathname] path
    # @return
    def import_files(path)
      Dir.entries(path)
         .reject { |f| File.directory?(File.join(path, f)) }
         .sort
         .map { |f| path.join(f) }
    end

    # Full path for a given subdirectory
    #
    # @param [String] subdirectory to use with the BASE_DIR
    # @return [Pathname]
    def import_path_for(subdirectory = nil)
      return BASE_DIR if subdirectory.nil?

      if !subdirectory.is_a?(String) || !Dir.exist?(BASE_DIR.join(subdirectory))
        raise ArgumentError, 'subdirectory does not exist'
      end

      BASE_DIR.join(subdirectory)
    end
  end
  # @!endgroup
end
