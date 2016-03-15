require 'nokogiri'
require './jobcase/jobcat'

boston_zip_codes = %w(
 02108 02109 02110 02111 02113 02114 02115 02116 02118 02119 02120 02121 02122
 02124 02125 02126 02127 02128 02129 02130 02131 02132 02134 02135 02136 02151
 02152 02163 02199 02203 02210 02215 02467
)

JobCat.load_from_files

filename = ARGV[0] || Date.today.strftime('jobcase/yh_%Y.%m.%d.xml')

if File.exists?(filename)
  puts "Loading from #{filename}"
else
  puts "Not found: #{ARGV[0]}"
  exit(1)
end

jobdoc = File.open(filename, 'r') { |f| Nokogiri::XML(f) }

def self.de_entitize(txt)
  txt = txt.to_s
  txt = txt.gsub('&quot;', '"')
  txt = txt.gsub('&apos;', "'")
  txt = txt.gsub('&gt;',   '>')
  txt = txt.gsub('&lt;',   '<')
  txt = txt.gsub('&amp;',  '&')
  txt
end

Event.transaction do

  # Anything we didn't update is deemed expired...

  Event.where_current.update_all(expires_at: (Date.today - 1).end_of_day)

  jobdoc.css("job").each do |job|
    title = job.css("title").text
    guid = job.css("guid").text
    category = job.css("job-category").text.strip
    url = job.css("url").text
    zip_code = job.css("zipcode").text.strip
    jobcat = JobCat.data_for_category(category)
    description = job.css("description").text
    if boston_zip_codes.include?(zip_code) && jobcat && jobcat.training_lvl && jobcat.training_lvl <= 2
      ev = Event.find_or_initialize_by jobcase_id: guid
      ev.attributes = {
        name: de_entitize(title),
        description: de_entitize(description),
        address: de_entitize(zip_code),
        url: de_entitize(url),
        expires_at: (Date.today+14).end_of_day
      }
      if !ev.save
        puts "Could not save jobcase job #{guid}"
      elsif jobcat
        jobcat.topics.each do |tp|
          ev.topics << tp
        end
        zip_category = Topic.find_or_create_by! \
        name: zip_code, topic_group: 'zip_code'
        ev.topics << zip_category
      end
    end
  end
end
