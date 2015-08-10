require 'indeed-ruby'
require 'nokogiri'
require 'open-uri'
require 'psych'

class IndeedDumper

  YAML_HEADER = <<-EOF
topics:
  job
  training
  diploma
  in_highschool
  no_diploma
  part_time
  full_time

EOF

  attr_reader :client

  def initialize(indeed_acct = ENV['INDEED_ACCT'])
    @client = Indeed::Client.new(indeed_acct)
  end

  def query(params, topics=[])
    results = indeed_query(params)

    returned_data = {}

    results.each do |item|
      description = description_from_url(item['url'])
      returned_data[item['jobkey']] = {
        name: "#{item['jobtitle']} at #{item['company']}",
        address: item['formattedLocation'],
        description: description,
        topics: topics + topics_from_description(description)
      }
    end
    returned_data
  end

  def indeed_query(params)
    params.merge!({
      l: 'Dorchester, MA',              # using ZIP_CODE gets no results...
      userip: '10.1.5.2',       # XXX TOS violation
      useragent: 'Mozilla/5.0 (Ubuntu)' # XXX TOS violation
    })


    res = @client.search(params)

    if res.nil? || res['results'].nil?
      raise IOError, 'Problem dealing with Indeed client'
    end

    res['results']
  end

  def description_from_url(url)
    begin
      doc = Nokogiri::HTML(open(url))
      content = doc.css("#job_summary").children.to_s + '<br/>'
    rescue
      content = ''
    end
    content + "<a class='btn btn-success btn-lg' href='#{url}'>Click here to apply!</a>"
  end

  def topics_from_description(description)
    topics = [:job]
    if description.downcase.include? "diploma"
      topics << :diploma
    else
      years = description.downcase.match(/(\d+)\.years/)
      if years.nil?
        topics << :no_diploma
      else
        years = years[0].to_i
        if years < 18
          topics << :in_highschool
        else
          topics << :no_diploma
        end
      end
    end
  end

  def query_to_yaml(search_terms, topics)
    YAML_HEADER + yaml_dump(query(search_terms, topics))
  end

  def query_to_file(search_terms, topics, file_name)
    File.open(file_name, 'w') do |f|
      f.puts query_to_yaml(search_terms, topics)
    end
  end

  def yaml_dump(result)
    unprocessed = Psych.dump(result)
    unprocessed.gsub!(/^---$/, '')
    unprocessed.gsub(/^([^ ])/, "\n\\1")
  end

end

# Sample usage:

if false
  dumper = IndeedDumper.new
  dumper.query_to_file({
                         jt: 'fulltime',
                         limit: 25
                       }, [:full_time],
                       'full_time.yml')
  dumper.query_to_file({
                         jt: 'parttime',
                         limit: 25
                       }, [:part_time],
                       'part_time.yml')
end

