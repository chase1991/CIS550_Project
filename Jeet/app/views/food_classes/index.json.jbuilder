json.array!(@food_classes) do |food_class|
  json.extract! food_class, :id, :name
  json.url food_class_url(food_class, format: :json)
end
