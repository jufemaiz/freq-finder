# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Freqfinder::Application.initialize!

include Geokit::Geocoders