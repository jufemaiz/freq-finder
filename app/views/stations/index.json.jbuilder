# frozen_string_literal: true

# app/views/stations/index.json.jbuilder
json.array! @stations do |station|
  json.partial! 'station', station:
end
