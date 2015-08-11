require 'csv'

module SurveyImport

  EMAIL_HEADER = "Respondent Email"
  INTEREST_HEADER = "Are you interested in receiving emails and/or text notifications about job opportunities?"

  SURVEY_QUESTIONS_ANSWERS = {
    "Which of the following job types interest you?" => {
      "Admin/office work" => "office",
      "Art/music/photography" => "art",
      "Advocacy/social justice/community organizing" => "advocacy",
      "Child care/camp/after-school program" => "camp",
      "Cleaning/indoor maintenance" => "custodial",
      "Construction/building/other trade" => "construction",
      "Environmental" => "environmental",
      "Food service" => "food service",
      "Hospitality/service" => "hospitality",
      "Landscaping/outdoor maintenance" => "landscaping",
      "Library" => "library",
      "Research" => "research",
      "Retail" => "retail",
      "Security" => "security",
      "Youth/peer leadership" => "peer leadership"
    },
    "Which of the following are you interested in?" => {
      "Career exploration opportunities" => "career exploration",
      "College-readiness programs" => "college prep",
      "Internships" => "internship",
      "Job-readiness workshops and trainings" => "job readiness",
      "Job specific trainings (i.e. culinary, building trades, computers, etc)" =>
        "training",
      "Personal development or mentorship" => "mentorship",
      "Volunteer opportunities" => "volunteer"
    },
    "What is your availability?" => {
      "Part-time" => "part_time",
      "Full-time" => "full_time"
    },
    "What is the highest level of education you have received?" => {
      "Middle/junior high school" => "in_highschool",
      "Some high school" => "in_highschool",
      "Bachelor's degree" => "college degree"
    },
    "What type of job opportunities are you interested in?" => {
      "Job to have all year long" => "full_year",
      "Summer job" => "summer",
      "Temporary/other seasonal job (i.e. holidays)" => "seasonal",
      "School-year job" => "school_year"
    },
    "How far are you willing to travel for a job or similar opportunity?" => {
      "Only local - Dorchester, Mattapan, Roxbury, etc." => "dorchester",
      "Anywhere in Boston" => "boston",
      "Anywhere in Eastern MA" => "eastern MA"
    }
  }

  class SurveyAnswer < Struct.new(:email, :user_opts_in, :topics)
  end

  def self.do_import(file)
    english_qa = get_english_qa(file)
    answers = english_qa_to_answers(english_qa)

    answers.each do |answer|
      if answer.user_opts_in
        user = User.find_by email: answer.email
        if user.nil?
          user = User.create_with_random_password! email: answer.email
        end
        answer.topics.each do |topic_str|
          topic = Topic.find_or_create_by name: topic_str
          user.interests.create! topic: topic
        end
      end
    end
  end

  def self.get_english_qa(file)
    csv_data = CSV.read(file)
    extract_timestamp = (csv_data.shift)[0]
    survey_id = (csv_data.shift)[0]
    headers = csv_data.shift
    subheaders = csv_data.shift

    parsed_data = csv_data.collect do |row|
      last_header = ''
      {}.tap do |hash|
        (0...headers.length).each do |i|
          have_header = !headers[i].empty?
          have_subheader = !subheaders[i].empty?
          if have_header && !have_subheader
            hash[headers[i]] = row[i]
          elsif have_header && have_subheader
            hash[headers[i]] = []
            hash[headers[i]] << row[i] unless row[i].empty?
            last_header = headers[i]
          else
            hash[last_header] << row[i] unless row[i].empty?
          end
        end
      end
    end
  end

  def self.english_qa_to_answers(english_qa)

    english_qa.collect{ |row|
      tags = []
      SURVEY_QUESTIONS_ANSWERS.each do |hdr, val_tags|

        add_val = ->(val) do
          if val_tags[val].nil?
            puts "Unrecognized val '#{val}' for '#{hdr}'"
          else
            tags << val_tags[val]
          end
        end

        vals = row[hdr]
        case vals
        when nil then puts "No answers for #{hdr}"
        when Array then 
          vals.each do |val| 
            add_val.call(val) 
          end
        else add_val.call(vals)
        end
      end
      SurveyAnswer.new(row[EMAIL_HEADER], 
                       (row[INTEREST_HEADER].downcase == "yes"), 
                       tags)
    }
  end
  
end

