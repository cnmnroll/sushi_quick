json.array!(@merchandises) do |merchandise|
  json.extract! merchandise, :id, :merchandise_name, :price, :stock, :category, :merchandise_status, :type_status
  json.url merchandise_url(merchandise, format: :json)
end
