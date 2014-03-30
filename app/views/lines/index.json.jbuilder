json.array!(@lines) do |line|
  json.extract! line, :id, :name, :start_time, :end_time, :days_of_week
  json.url line_url(line, format: :json)
end
