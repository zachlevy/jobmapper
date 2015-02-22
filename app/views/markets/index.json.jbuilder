json.array!(@markets) do |market|
  json.extract! market, :id, :noc_id, :name
  json.url market_url(market, format: :json)
end
