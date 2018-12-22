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
    @transmitters = if @station.nil?
                      Transmitter
                    else
                      @station.transmitters
                    end
    @transmitters = @transmitters.by_distance_with_backup_sort(@location).all
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
    puts params[:location]
    return unless Location.valid_gps?(params[:location])

    @location = Location.normalize(params[:location])
    puts @location.inspect
  end
end
