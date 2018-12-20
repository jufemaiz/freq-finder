# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
#
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#    movies = Movie.create(
#      [{ name: 'Star Wars' }, { name: 'Lord of the Rings' }]
#    )
#    Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# Converts a string to a numeric value for latitude
#
# 34 50 07S
#
# @param [String] string
# @return [Numeric]
def string_to_latitude(string)
  string.scan(/(\d+)\s(\d+)\s(\d+)([NS])/)
        .map do |d, m, s, pp|
          (d.to_f + m.to_f / 60 + s.to_f / 3600) * (pp == 'N' ? 1 : -1)
        end.first
end

# Converts a string to a numeric value for longitude
#
# 138 34 28E
#
# @param [String] string
# @return [Numeric]
def string_to_longitude(string)
  string.scan(/(\d+)\s(\d+)\s(\d+)([NS])/)
        .map do |d, m, s, pp|
          (d.to_f + m.to_f / 60 + s.to_f / 3600) * (pp == 'E' ? 1 : -1)
        end.first
end

# Import Stations
CSV.foreach('public/src/acma/201107_station_listing.txt') do |row|
  row[0] ||= ''
  row[0] = '' if row[0].blank?
  Station.find_or_create_by_title(row[0])
end

stations = {}
Station.find(:all).each do |s|
  stations[s.title] = s.id
end

# Import Transmitters
# 00  Band                            string
# 01  On Air ID                       string
# 02  Area Served                     string
# 03  Callsign                        string
# 04  Frequency(kHz)                  float
# 05  Purpose                         string
# 06  Polarisation                    string
# 07  Antenna Height (m)              integer
# 08  Antenna Pattern                 string
# 09  Maximum ERP (W)                 integer
# 10  Maximum CMF (V)                 integer
# 11  Transmitter Power (W)           integer
# 12  Technical Specification Number  integer
# 13  Licence Number                  integer
# 14  Site Id                         integer
# 15  Site Name                       string
# 16  Zone                            integer
# 17  Easting                         integer
# 18  Northing                        integer
# 19  Latitude                        float
# 20  Longitude                       float
# 21  State                           string
# 22  BSL                             integer
# 23  Licence Area                    string
# 24  Licence Area ID                 integer
# 25  Hours of Operation              string
# 26  Status                          string
CSV.foreach('public/src/acma/201107_transmitter_listing.csv') do |row|
  if %w[AM FM].include?(row[0])
    row[1] ||= ''
    row[1] = stations[row[1]] || nil
    row[4] = row[4].to_f
    row[7] = row[7].to_i
    row[9] = row[9].to_i
    row[10] = row[10].to_i
    row[11] = row[11].to_i
    row[12] = row[12].to_i
    row[13] = row[13].to_i
    row[14] = row[14].to_i
    row[16] = row[16].to_i
    row[17] = row[17].to_i
    row[18] = row[18].to_i
    row[19] = string_to_latitude(row[19])
    row[20] = string_to_longitude(row[20])
    row[22] = row[22].to_i
    row[24] = row[24].to_i

    Transmitter.create(
      band: row[0],
      station_id: row[1],
      area: row[2],
      callsign: row[3],
      frequency: row[4],
      purpose: row[5],
      polarisation: row[6],
      antenna_height: row[7],
      antenna_pattern: row[8],
      maximum_erp: row[9],
      maximum_cmf: row[10],
      power: row[11],
      technical_specification_number: row[12],
      license_number: row[13],
      site_id: row[14],
      site_name: row[15],
      zone: row[16],
      easting: row[17],
      northing: row[18],
      lat: row[19],
      lng: row[20],
      state: row[21],
      bsl: row[22],
      license_area: row[23],
      license_id: row[24],
      operation_hours: row[25],
      status: row[26]
    )
  end
end
