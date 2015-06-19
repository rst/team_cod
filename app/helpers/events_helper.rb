module EventsHelper
  def by_paragraphs(txt)
    txt.split(/\n\s*\n/)
  end

  def event_map_link(event)
    addr = event.address.gsub("\r", '').gsub("\n", ",")
    raw("http://maps.google.com/maps?" + {q: addr}.to_query)
  end
end
