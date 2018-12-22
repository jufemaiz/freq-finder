# frozen_string_literal: true

# app/views/transmitters/index.json.jbuilder
json.array! @transmitters do |transmitter|
  json.partial! 'transmitter', transmitter: transmitter
  json.station do
    json.partial! 'stations/station', station: transmitter.station
  end
end
