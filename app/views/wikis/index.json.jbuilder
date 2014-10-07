json.array!(@wikis) do |wiki|
  json.extract! wiki, :id, :title, :user_id, :is_private
  json.url wiki_url(wiki, format: :json)
end
