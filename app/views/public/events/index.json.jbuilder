json.array!(@events) do |event|
  json.id event.id
  json.title event.name
  json.start "#{event.date} #{event.time.strftime('%H:%m')}"
  json.end "#{event.date} #{event.time.strftime('%H:%m')}"
  json.url event_url(event.id, format: :html)
end