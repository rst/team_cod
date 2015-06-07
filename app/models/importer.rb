class Importer

  def self.load_file(file)
    File.open(file, 'r') do |f|
      self.load_string(f.read)
    end
  end

  def self.load_string(str)
    self.load_data(Psych.load(str))
  end

  def self.load_data(data)
    topic_names = data.delete("topics").split
    topics_map = {}

    topic_names.each do |name|
      topic = Topic.where(name: name).first
      if topic.nil?
        puts "creating topic '#{name}'"
        topic = Topic.create! name: name
      end
      topics_map[name.to_sym] = topic
    end

    puts topics_map.inspect

    data.each do |key, event|
      event = event.symbolize_keys

      if event[:name].nil?
        puts "Name missing for #{key}"
        next
      end

      if event[:description].nil?
        puts "Description missing for #{key}"
        next
      end

      ev_topics = event[:topics].collect { |name|
        if topics_map[name].nil?
          puts "Unknown topic: '#{name}'"
        end
        topics_map[name]
      }.compact

      ev = Event.create! name: event[:name], description: event[:description]

      ev.topics << ev_topics
    end

  end

end
