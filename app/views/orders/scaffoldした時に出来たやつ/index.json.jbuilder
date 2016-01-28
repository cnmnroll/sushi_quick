json.array!(@orders) do |order|
  json.extract! order, :id, :order_date, :order_time, :user_num, :user_address, :total, :delivery_status
  json.url order_url(order, format: :json)
end
