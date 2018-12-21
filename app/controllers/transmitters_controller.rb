# frozen_string_literal: true

# [TransmittersController]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class TransmittersController < ApplicationController
  before_action :set_station, only: [:index]
  before_action :set_location, only: %i[index show]
  before_action :set_transmitter, only: [:show]

  LATLNG_PATTERN = /^(-?\d+\.\d+),(-?\d+\.\d+)$/

  # GET /stations
  def index
    logger.info("@station: #{@station.inspect}")
    logger.info("@location: #{@location.inspect}")

    @transmitters = Transmitter
    @transmitters = @transmitters.where(station: @station) unless @station.nil?
    @transmitters = @transmitters.by_distance(origin: @location) unless @location.nil?
    @transmitters = @transmitters.all
    # logger.info("@transmitters: #{@transmitters.inspect}")
  end

  # GET /stations/:id
  def show; end

  private

  # Sets the `@station` if `:station_id` is present in `params`
  #
  # @return [void]
  def set_station
    return unless params[:station_id]
    @station = Station.find(params[:station_id])
    puts "@station: #{@station.to_json}"
  end

  # Sets the `@transmitter` if `:id` is present in `params`
  #
  # @return [void]
  def set_transmitter
    return unless params[:id]
    @transmitter = Transmitter.find(params[:id])
  end

  # Sets the `@location` if `:latlng` is present in `params`
  #
  # @return [void]
  def set_location
    return unless params[:latlng] &&
      params[:latlng].match()

    @location = Geokit::LatLng.normalize(
      params[:latlng].split(',')
    )
  end
end
