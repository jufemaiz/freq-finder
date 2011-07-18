class SearchController < ApplicationController

  # GET /
  def index
    
    if params[:latlng]
      redirect_to("/transmitters/?latlng=" + latlng)
    else
      redirect_to "/" unless params.nil?
    end
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /results
  # GET /results.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
