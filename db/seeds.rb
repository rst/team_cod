# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

job = Topic.create!({name: :job})
training = Topic.create!({name: :training})
diploma = Topic.create!({name: :diploma})
in_highschool = Topic.create!({name: :in_highschool})
no_diploma = Topic.create!({name: :no_diploma})
part_time = Topic.create!({name: :part_time})
full_time = Topic.create!({name: :full_time})

resume_builder = Event.create!({name: "Resume Builder", description: "Come build your resume!" })
job_fair = Event.create!({name: "Job Fair", description: "GET HIRED!"})
data_entry = Event.create!({name: "Data Entry", description: "Dunder Mifflin"}) # Diploma, part time
receptionist = Event.create!({name: "Receptionist", description: "Microsoft"}) # Diploma, full time
brand_ambassador = Event.create!({name: "Brand Ambassador", description: "zipcar"}) # no diploma, after high school, full time
dish_washer = Event.create!({name: "Dish Washer", description: "Restaurant"}) # no diploma, after high school, part time
grocery_bagger = Event.create!({name: "Grocery Bagger", description: "Grocery Store"}) # in high school, part time
cook = Event.create!({name: "Cook", description: "Restaurant"}) # in high school, part time
retail = Event.create!({name: "Retail", description: "Walmart"}) # no req, full time


EventTopic.create! event: resume_builder, topic: training
EventTopic.create! event: job_fair, topic: training

EventTopic.create! event: data_entry, topic: job
EventTopic.create! event: receptionist, topic: job
EventTopic.create! event: brand_ambassador, topic: job
EventTopic.create! event: dish_washer, topic: job
EventTopic.create! event: grocery_bagger, topic: job
EventTopic.create! event: cook, topic: job
EventTopic.create! event: retail, topic: job

EventTopic.create! event: data_entry, topic: diploma
EventTopic.create! event: receptionist, topic: diploma
EventTopic.create! event: brand_ambassador, topic: no_diploma
EventTopic.create! event: dish_washer, topic: no_diploma
EventTopic.create! event: grocery_bagger, topic: in_highschool
EventTopic.create! event: cook, topic: in_highschool
EventTopic.create! event: retail, topic: no_diploma

EventTopic.create! event: data_entry, topic: part_time
EventTopic.create! event: receptionist, topic: full_time
EventTopic.create! event: brand_ambassador, topic: full_time
EventTopic.create! event: dish_washer, topic: part_time
EventTopic.create! event: grocery_bagger, topic: part_time
EventTopic.create! event: cook, topic: part_time
EventTopic.create! event: retail, topic: full_time
