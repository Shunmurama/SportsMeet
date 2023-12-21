json.array! @events do |event|
  json.id event.id
  json.name event.name
  json.time event.time
end