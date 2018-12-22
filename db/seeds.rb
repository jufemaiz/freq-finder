# frozen_string_literal: true

BASE_DIR = Rails.root.join('public', 'yaml')

Dir.entries(BASE_DIR)
   .reject { |f| File.directory?(File.join(BASE_DIR, f)) }
   .sort
   .each do |station_file|
  station_data = YAML.load_file(File.join(BASE_DIR, station_file))

  puts "Seeding: #{station_data[:title]}"

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

    puts transmitter.inspect
    puts t.errors.messages
  end
end
