# config/initializers/geocoder.rb
Geocoder.configure(

  :use_https => true,

  # geocoding service (see below for supported options):
  :lookup => :google,

  # to use an API key:
  :api_key => Rails.application.config.google_geocode_key,

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,

  # caching (see below for details):
  # :cache => Redis.new,
  # :cache_prefix => "..."

)
