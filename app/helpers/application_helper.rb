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
end
