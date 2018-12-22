# frozen_string_literal: true

# app/views/transmitters/show.json.jbuilder
json.partial! 'transmitter', transmitter: @transmitter
json.station do
  json.partial! 'stations/station', station: @transmitter.station
end
