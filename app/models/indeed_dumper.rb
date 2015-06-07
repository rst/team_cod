ZIP_CODE = 02124                # Codman Hill

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

  def query(search_terms)

    params = {
      q: search_terms, 
      l: 'Boston',              # using ZIP_CODE gets no results...
      userip: '10.1.5.2',       # XXX TOS violation
      useragent: 'Mozilla/5.0 (Ubuntu)' # XXX TOS violation
    }

    res = @client.search(params)

    if res.nil? || res['results'].nil?
      raise IOError('Problem dealing with Indeed client')
    end

    returned_data = {}

    res['results'].each do |item|
      returned_data[item['jobkey']] = {
        name: "#{item['jobtitle']} at #{item['company']}",
        address: item['formattedLocation'],
        description: item['snippet'],
        url: item['url'],
        topics: ''
      }
    end

    return returned_data

  end
  
  def query_to_yaml(search_terms)
    YAML_HEADER + yaml_dump(query(search_terms))
  end

  def query_to_file(search_terms, file_name)
    File.open(file_name, 'w') do |f|
      f.puts query_to_yaml(search_terms)
    end
  end

  def yaml_dump(result)
    unprocessed = Psych.dump(result)
    unprocessed.gsub!(/^---$/, '')
    unprocessed.gsub(/^([^ ])/, "\n\\1")
  end

end
