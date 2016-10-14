json.extract! search, :id, :price, :location, :floor, :lift, :surface, :room, :bedroom, :to_renovate, :comment, :option, :created_at, :updated_at
json.url user_search_url(search, format: :json)
