require 'parse-ruby-client'
Parse.init :application_id => "7pw4FPFfdNZa3BokXn29zXGbLg7nP9DYwUDY9Err",
            :api_key        => "e9Sj3tqLr1wQnkGaY4b1Wz0owo1zymmQPTEsElIE",
            :quiet           => true | false 
module ApplicationHelper

  def get_parse_locations
    locations = Parse::Query.new("Location").tap do |q|
      q.limit = 1000
    end.get
    #puts locations
    locations.each do |location|
      next unless location["gc_city_id"]
      l = Location.new(gov_id: location["gc_city_id"], name: location["name"])
      l.save
    end
  end

  def get_parse_markets
    markets = Parse::Query.new("Market").tap do |q|
      q.limit = 1000
    end.get
    #puts locations
    markets.each do |market|
      next unless market["nocId"]
      m = Market.new(noc_id: market["nocId"], name: market["nocName"])
      m.save
    end
  end

  def post_parse_job_locations
    # Job check if address field
    # if there is, get latitude and longitude
    # post to parse
    jobs = Parse::Query.new("Job").tap do |q|
      q.limit = 1000
      q.exists("address", true)
      q.exists("latitude", false)
      q.exists("longitude", false)
    end.get
    jobs.each do |job|
      coords = address_coords job['address']
      if coords != false
        job['latitude'] = coords.lat
        job['longitude'] = coords.lng
        job.save
      end
    end
  end

  # not dry
  def address_coords address
    loc = Geokit::Geocoders::MultiGeocoder.geocode(address)
    loc.success ? loc : false
  end
end
