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

# resume_builder = Event.create!({name: "Resume Builder", description: "Come build your resume!" })
# job_fair = Event.create!({name: "Job Fair", description: "GET HIRED!"})
# data_entry = Event.create!({name: "Data Entry", description: "Dunder Mifflin"}) # Diploma, part time
# receptionist = Event.create!({name: "Receptionist", description: "Microsoft"}) # Diploma, full time
# brand_ambassador = Event.create!({name: "Brand Ambassador", description: "zipcar"}) # no diploma, after high school, full time
# dish_washer = Event.create!({name: "Dish Washer", description: "Restaurant"}) # no diploma, after high school, part time
# grocery_bagger = Event.create!({name: "Grocery Bagger", description: "Grocery Store"}) # in high school, part time
# cook = Event.create!({name: "Cook", description: "Restaurant"}) # in high school, part time
# retail = Event.create!({name: "Retail", description: "Walmart"}) # no req, full time

<<<<<<< HEAD
EventTopic.create! event: resume_builder, topic: training
EventTopic.create! event: job_fair, topic: training
=======

# EventTopic.create! event: resume_builder, topic: training
# EventTopic.create! event: job_fair, topic: training
>>>>>>> e5699c44dd25664ef18cac0fab52bf705b6fe84a

# EventTopic.create! event: data_entry, topic: job
# EventTopic.create! event: receptionist, topic: job
# EventTopic.create! event: brand_ambassador, topic: job
# EventTopic.create! event: dish_washer, topic: job
# EventTopic.create! event: grocery_bagger, topic: job
# EventTopic.create! event: cook, topic: job
# EventTopic.create! event: retail, topic: job

# EventTopic.create! event: data_entry, topic: diploma
# EventTopic.create! event: receptionist, topic: diploma
# EventTopic.create! event: brand_ambassador, topic: no_diploma
# EventTopic.create! event: dish_washer, topic: no_diploma
# EventTopic.create! event: grocery_bagger, topic: in_highschool
# EventTopic.create! event: cook, topic: in_highschool
# EventTopic.create! event: retail, topic: no_diploma

<<<<<<< HEAD
EventTopic.create! event: data_entry, topic: part_time
EventTopic.create! event: receptionist, topic: full_time
EventTopic.create! event: brand_ambassador, topic: full_time
EventTopic.create! event: dish_washer, topic: part_time
EventTopic.create! event: grocery_bagger, topic: part_time
EventTopic.create! event: cook, topic: part_time
EventTopic.create! event: retail, topic: full_time

# real data
kfc_team_member = Event.create!({name: "KFC Team Member", description: "As a Team Member, you could be the smiling face that greets and serves customers. Or you could be the cook that prepares our world famous chicken (and tell your friends you know the “secret” – just kiddin’). Whatever job you do, you know what you do matters – to your team and to your customers.
https://jobs.kfc.com/job/dorchester/kfc-team-member/1672/148210 
"}) # no req, full time
EventTopic.create! event: kfc_team_member, topic: job
EventTopic.create! event: kfc_team_member, topic: no_diploma
EventTopic.create! event: kfc_team_member, topic: full_time
EventTopic.create! event: kfc_team_member, topic: part_time

kfc_general_manager = Event.create!({name: "KFC General Manager", description: "If you’re already a successful manager, you need to check out our Restaurant General Manager position. As a Restaurant General Manager, you have the keys to a $1 million+ business (literally!). And when you grow your team and the business by making our customers’ day, you get rewarded in a big way. 
https://jobs.kfc.com/job/dorchester/kfc-restaurant-general-manager/1672/144586 
"}) # no req, full time
EventTopic.create! event: kfc_general_manager, topic: job
EventTopic.create! event: kfc_general_manager, topic: no_diploma
EventTopic.create! event: kfc_general_manager, topic: full_time

kfc_assistant_manager = Event.create!({name: "KFC Assistant Manager", description: "If you’re looking to be a manager of your own business but don’t know how to get started, check out our Assistant Restaurant Manager position. As an Assistant Restaurant Manager, you are second in command of a $1 million+ business. Working with your Restaurant General Manager, you grow the business by making our customers’ day. And when you do, you get rewarded in a big way.

https://jobs.kfc.com/job/dorchester/kfc-assistant-restaurant-manager/1672/147712"}) # no req, full time
EventTopic.create! event: kfc_assistant_manager, topic: job
EventTopic.create! event: kfc_assistant_manager, topic: no_diploma
EventTopic.create! event: kfc_assistant_manager, topic: full_time

kfc_shift_supervisor = Event.create!({name: "KFC Shift Supervisor", description: "If you’re ready for a career in restaurant management, our Shift Supervisor position is the right place to start. Working as a Shift Supervisor lets you develop your management skills while still having the time to do the things you enjoy. You’ll benefit from our training and career opportunities and receive reward and recognition for your efforts.

https://jobs.kfc.com/job/dorchester/kfc-shift-supervisor/1672/149683"}) # no req, full time
EventTopic.create! event: kfc_shift_supervisor, topic: job
EventTopic.create! event: kfc_shift_supervisor, topic: no_diploma
EventTopic.create! event: kfc_shift_supervisor, topic: full_time

office_max_sales_consultant = Event.create!({name: "Office Max Sales Consultant", description: "http://jobs.officedepot.com/job/5234296/retail-sales-consultant-dorchester-ma/"}) # no req, full time
EventTopic.create! event: office_max_sales_consultant, topic: job
EventTopic.create! event: office_max_sales_consultant, topic: diploma
EventTopic.create! event: office_max_sales_consultant, topic: full_time

starbucks_barista = Event.create!({name: "Starbucks Barista", description: "http://www.starbucks.com/careers/college-plan?cm_mmc=google-_-BR%20-%20Brand%20-%20SCAP%20Phrase-_-Brand%20-%20Starbucks%20Jobs-_-starbucks%20jobs_mkwid|scqCc9Khl_dc|pcrid|62539574666|pkw|starbucks%20jobs|pmt|p&utm_medium=cpc&gclid=CPbV2LCC_sUCFZYWHwod-7IAog&utm_source=google&utm_campaign=BR+-+Brand+-+SCAP+Phrase&utm_term=starbucks+jobs

https://wfa.kronostm.com/index.jsp?INDEX=0&LOCATION_ID=24197625066&locale=en_US&applicationName=StarbucksNonReqExt&EVENT=com.deploy.application.hourly.plugin.SelectAdditionalLocations.doSearch&SEQ=selectAdditionalLocations&POSTING_ID=667441924 "}) # no req, full time
EventTopic.create! event: starbucks_barista, topic: job
EventTopic.create! event: starbucks_barista, topic: no_diploma
EventTopic.create! event: starbucks_barista, topic: part_time

bed_bath_and_beyond_manager = Event.create!({name: "Bed Bath And Beyond Manager", description: "https://www.hrapply.com/bbb/AppJobView.jsp?link=6323&page=AppJobList.jsp&skimSessionName=com.hrlogix.view.cont.table.cs.req.JobListTable&skimName=requisition.requisition_id&skimNdx=13&op=reset"}) # no req, full time
EventTopic.create! event: bed_bath_and_beyond_manager, topic: job
EventTopic.create! event: bed_bath_and_beyond_manager, topic: no_diploma
EventTopic.create! event: bed_bath_and_beyond_manager, topic: full_time

marshalls_merchandising_development = Event.create!({name: "Marshall's Merchandising Development", description: "GPA requirement 3.0
https://career8.successfactors.com/career?career_ns=job_listing&company=TJX&navBarLevel=JOB_SEARCH&rcm_site_locale=en_US&career_job_req_id=63701&selected_lang=en_US&jobAlertController_jobAlertId=&jobAlertController_jobAlertName=&_s.crb=jeMRIIQjJoUmj5pyJzqgKFPdhMU%3d "}) # no req, full time
EventTopic.create! event: marshalls_merchandising_development, topic: job
EventTopic.create! event: marshalls_merchandising_development, topic: training
EventTopic.create! event: marshalls_merchandising_development, topic: no_diploma
EventTopic.create! event: marshalls_merchandising_development, topic: full_time

amc_film_crew = Event.create!({name: "AMC Film Crew", description: "https://sjobs.brassring.com/TGWebHost/jobdetails.aspx?SID=%5eRvnLQlU9TYFUGWjpWNbhUQby8tRIOIDB2R42o9PuXXH50PGFzQkuNTZQpBvcdKRn&jobId=351692&type=search&JobReqLang=1&recordstart=1&JobSiteId=5197&JobSiteInfo=351692_5197&GQId=795"}) # no req, full time
EventTopic.create! event: amc_film_crew, topic: job
EventTopic.create! event: amc_film_crew, topic: no_diploma
EventTopic.create! event: amc_film_crew, topic: full_time
EventTopic.create! event: amc_film_crew, topic: part_time
=======
# EventTopic.create! event: data_entry, topic: part_time
# EventTopic.create! event: receptionist, topic: full_time
# EventTopic.create! event: brand_ambassador, topic: full_time
# EventTopic.create! event: dish_washer, topic: part_time
# EventTopic.create! event: grocery_bagger, topic: part_time
# EventTopic.create! event: cook, topic: part_time
# EventTopic.create! event: retail, topic: full_time
>>>>>>> e5699c44dd25664ef18cac0fab52bf705b6fe84a
