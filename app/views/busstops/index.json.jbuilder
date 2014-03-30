json.array!(@busstops) do |busstop|
  json.extract! busstop, :id, :name, :lat, :lnt, :kind
  json.url busstop_url(busstop, format: :json)
end
