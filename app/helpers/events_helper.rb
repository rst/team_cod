module EventsHelper
  def by_paragraphs(txt)
    txt.split(/\n\s*\n/)
  end
end
