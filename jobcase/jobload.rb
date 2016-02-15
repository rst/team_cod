require 'nokogiri'
require './jobcase/jobcat'

boston_zip_codes = %w(
 02108 02109 02110 02111 02113 02114 02115 02116 02118 02119 02120 02121 02122
 02124 02125 02126 02127 02128 02129 02130 02131 02132 02134 02135 02136 02151
 02152 02163 02199 02203 02210 02215 02467
)

JobCat.load_from_files

jobdoc = File.open("jobcase/youthhub.xml") { |f| Nokogiri::XML(f) }

jobdoc.css("job").each do |job|
  title = job.css("title").text
  guid = job.css("guid").text
  category = job.css("job-category").text.strip
  url = job.css("url")
  zip_code = job.css("zipcode").text.strip
  jobcat = JobCat.data_for_category(category)
  description = job.css("description")
  if boston_zip_codes.include?(zip_code) && jobcat && jobcat.training_lvl && jobcat.training_lvl <= 2
    ev = Event.find_or_initialize_by jobcase_id: guid
    ev.attributes = {
      name: title,
      description: description,
      address: zip_code,
      url: url
    }
    if !ev.save
      puts "Could not save jobcase job #{guid}"
    elsif jobcat
      jobcat.topics.each do |tp|
        ev.topics << tp
      end
    end
  end
end
