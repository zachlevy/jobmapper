json.array!(@jobs) do |job|
  json.extract! job, :id, :latitude, :longitude, :title
  json.url job_url(job, format: :json)
end
