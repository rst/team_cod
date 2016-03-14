require 'csv'

class JobCat < Struct.new(:category, :name, :training_lvl, :topics)

  @jobcats = {}

  def self.load_from_files
    CSV.open("jobcase/jobcats.csv") do |csv|
      csv.each do |row|
        category, name = row
        @jobcats[category] = JobCat.new(category, name, nil, [])
      end
    end

    CSV.open("jobcase/jobzones.csv") do |csv|
      csv.each do |row|
        category, zone = row
        str = @jobcats[category]
        if str
          str.training_lvl = zone.to_i
        elsif category != 'onetsoc_code' && false
          puts "Can't find category #{category}"
        end
      end
    end

    @jobcats.values.each do |cat|
      if cat.training_lvl.nil? && false
        puts "No training level for #{cat.category}"
      end
    end

    File.open("jobcase/jobcats.subcategories", "r") do |f|
      current_topic = nil
      f.each_line do |line|
        if line.match(/^\S/)    # not whitespace
          tname = line.strip
          unless %w(Nil Other).include? tname
            current_topic = Topic.find_or_create_by \
               name: line.strip,
               topic_group: 'job_skills_category'
          end
        else
          category = (line.split)[2]
          data = @jobcats[category]
          if data.nil?
            puts "Category assignment for bogus jobcat #{category}"
          elsif !current_topic.nil?
            data.topics << current_topic
          end
        end
      end
    end
    
  end

  def self.data_for_category(cat)
    @jobcats[cat]
  end

end

