module JobsHelper
  def ip() request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip end

  def address_coords address
    loc = Geokit::Geocoders::MultiGeocoder.geocode(address)
    loc.success ? loc : false
  end

  def default_location
    here = Geokit::Geocoders::MultiGeocoder.geocode(ip())
    here.lat = here.lat || 43.6525
    here.lng = here.lng || -79.368599
    here
  end

  def get_city gc_city_id
    return Location.find(gc_city_id)
  end

  # takes in an array of categories
  def get_markers markets, locations
    puts "===== GET MARKERS ====="
    puts markets
    puts locations

    parse_jobs = Parse::Query.new("Job").tap do |q|
      q.limit = 2
      if markets.any?
        q.value_in("nocId", markets)
      end
      if locations.any?
        q.value_in("gc_city_id", locations)
      end
    end.get

    jobs = []
    parse_jobs.each do |job|
      location = Location.find(job['gc_city_id'])
      address = "#{job['employer']}, #{job['postalCode'].to_s}, #{location.name}"
      puts job['datePosted']
      j = Job.new(title: job['title'], address: address, link: job['jobUrl'], employer: job['employer'])
      jobs << j
    end

    markers = Gmaps4rails.build_markers(jobs) do |job, marker|
      if job.latitude
        # do nothing
      elsif job.address
        # get coords from the address
        coords = address_coords job.address
        next unless coords
        job.latitude = coords.lat
        job.longitude = coords.lng
      end
      # create the marker
      marker.lat job.latitude
      marker.lng job.longitude
      marker.infowindow "<a href=\"#{job.link}\" target=\"_blank\">#{job.title}</a><br/>#{job.employer}<br />Posted: #{job.posted_at}"
    end
    markers
  end
end
