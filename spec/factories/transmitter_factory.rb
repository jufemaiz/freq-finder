# frozen_string_literal: true

FactoryBot.define do
  factory :transmitter do
    station

    antenna_height { rand(0..2500) }
    sequence(:antenna_pattern) { |n| n.even? ? 'DA' : 'OD' }
    area { 'Area' }
    sequence(:band) { |n| n.even? ? 'AM' : 'FM' }
    bsl { 0 }
    sequence(:callsign) { |n| n.even? ? '2BL' : '2JJJ' }
    easting { 0 }
    sequence(:frequency) { |n| n.even? ? 702 : 105.7 }
    lat { Faker::Address.latitude }
    license_area { 1 }
    license_id { 0 }
    license_number { 0 }
    lng { Faker::Address.longitude }
    maximum_cmf { 0 }
    maximum_erp { 0 }
    northing { 0 }
    operation_hours { 'day-time' }
    polarisation { 'H' }
    power { 0 }
    purpose { 'Commercial' }
    site_id { 0 }
    site_name { Faker::Pokemon.name }
    state { 'NSW' }
    status { 'Issued' }
    technical_specification_number { 0 }
    zone { 0 }
  end
end
