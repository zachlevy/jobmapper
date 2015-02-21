module JobsHelper
  def ip() request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip end

  def address_coords address
    loc = Geokit::Geocoders::MultiGeocoder.geocode(address)
    loc.success ? loc : false
  end
end
