json.array!(@order_details) do |order_detail|
  json.extract! order_detail, :id, :order_num, :merchandise_num, :quantity, :subtotal
  json.url order_detail_url(order_detail, format: :json)
end
