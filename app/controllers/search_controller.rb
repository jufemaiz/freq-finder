# frozen_string_literal: true

# [SearchController]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class SearchController < ApplicationController
    # GET /
  def index
    respond_to do |format|
      format.json
    end
  end

  # # GET /search.json
  # def search
  #   if params[:q]
  #     @address = GoogleGeocoder.reverse_geocode(params[:q])
  #     if @address.full_address.nil?
  #       redirect_to root_path
  #     else
  #       redirect_to transmitters_path(
  #         latlng: [@address.lat, @address.lng].join(',')
  #       )
  #     end
  #   else
  #     redirect_to root_path
  #   end
  #
  #   respond_to do |format|
  #     format.json
  #   end
  # end

  # GET /geolocate.json
  def search
    if !params[:latlng].nil? &&
      params[:latlng].match(/^(-?\d+\.\d+),(-?\d+\.\d+)$/)

      latlng = Geokit::LatLng.normalize(params[:latlng])
      redirect_to transmitters_path(latlng: latlng)
    else
      redirect_to root_path
    end
  end
end
