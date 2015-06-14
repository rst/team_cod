# -*- coding: utf-8 -*-
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
EventTopic.create! event: resume_builder, topic: training
EventTopic.create! event: job_fair, topic: training

# real data
kfc_team_member = Event.create!({name: "KFC Team Member", 
url: "https://jobs.kfc.com/job/dorchester/kfc-team-member/1672/148210",
description: "As a Team Member, you could be the smiling face that greets and serves customers. Or you could be the cook that prepares our world famous chicken (and tell your friends you know the “secret” – just kiddin’). Whatever job you do, you know what you do matters – to your team and to your customers."}) # no req, full time
EventTopic.create! event: kfc_team_member, topic: job
EventTopic.create! event: kfc_team_member, topic: no_diploma
EventTopic.create! event: kfc_team_member, topic: full_time
EventTopic.create! event: kfc_team_member, topic: part_time

kfc_general_manager = Event.create!({name: "KFC General Manager", 
url: "https://jobs.kfc.com/job/dorchester/kfc-restaurant-general-manager/1672/144586",
description: "If you’re already a successful manager, you need to check out our Restaurant General Manager position. As a Restaurant General Manager, you have the keys to a $1 million+ business (literally!). And when you grow your team and the business by making our customers’ day, you get rewarded in a big way."}) # no req, full time
EventTopic.create! event: kfc_general_manager, topic: job
EventTopic.create! event: kfc_general_manager, topic: no_diploma
EventTopic.create! event: kfc_general_manager, topic: full_time

kfc_assistant_manager = Event.create!({name: "KFC Assistant Manager", 
url: "https://jobs.kfc.com/job/dorchester/kfc-assistant-restaurant-manager/1672/147712",
description: "If you’re looking to be a manager of your own business but don’t know how to get started, check out our Assistant Restaurant Manager position. As an Assistant Restaurant Manager, you are second in command of a $1 million+ business. Working with your Restaurant General Manager, you grow the business by making our customers’ day. And when you do, you get rewarded in a big way."}) # no req, full time
EventTopic.create! event: kfc_assistant_manager, topic: job
EventTopic.create! event: kfc_assistant_manager, topic: no_diploma
EventTopic.create! event: kfc_assistant_manager, topic: full_time

kfc_shift_supervisor = Event.create!({name: "KFC Shift Supervisor", 
url: "https://jobs.kfc.com/job/dorchester/kfc-shift-supervisor/1672/149683",
description: "If you’re ready for a career in restaurant management, our Shift Supervisor position is the right place to start. Working as a Shift Supervisor lets you develop your management skills while still having the time to do the things you enjoy. You’ll benefit from our training and career opportunities and receive reward and recognition for your efforts."}) # no req, full time
EventTopic.create! event: kfc_shift_supervisor, topic: job
EventTopic.create! event: kfc_shift_supervisor, topic: no_diploma
EventTopic.create! event: kfc_shift_supervisor, topic: full_time

office_max_sales_consultant = Event.create!({name: "Office Max Sales Consultant", 
url: "http://jobs.officedepot.com/job/5234296/retail-sales-consultant-dorchester-ma/",
description: ""}) # no req, full time
EventTopic.create! event: office_max_sales_consultant, topic: job
EventTopic.create! event: office_max_sales_consultant, topic: diploma
EventTopic.create! event: office_max_sales_consultant, topic: full_time

starbucks_barista = Event.create!({name: "Starbucks Barista", 
url: "https://wfa.kronostm.com/index.jsp?INDEX=0&LOCATION_ID=24197625066&locale=en_US&applicationName=StarbucksNonReqExt&EVENT=com.deploy.application.hourly.plugin.SelectAdditionalLocations.doSearch&SEQ=selectAdditionalLocations&POSTING_ID=667441924",
description: "http://www.starbucks.com/careers/college-plan?cm_mmc=google-_-BR%20-%20Brand%20-%20SCAP%20Phrase-_-Brand%20-%20Starbucks%20Jobs-_-starbucks%20jobs_mkwid|scqCc9Khl_dc|pcrid|62539574666|pkw|starbucks%20jobs|pmt|p&utm_medium=cpc&gclid=CPbV2LCC_sUCFZYWHwod-7IAog&utm_source=google&utm_campaign=BR+-+Brand+-+SCAP+Phrase&utm_term=starbucks+jobs
"}) # no req, full time
EventTopic.create! event: starbucks_barista, topic: job
EventTopic.create! event: starbucks_barista, topic: no_diploma
EventTopic.create! event: starbucks_barista, topic: part_time

bed_bath_and_beyond_manager = Event.create!({name: "Bed Bath And Beyond Manager", 
url: "https://www.hrapply.com/bbb/AppJobView.jsp?link=6323&page=AppJobList.jsp&skimSessionName=com.hrlogix.view.cont.table.cs.req.JobListTable&skimName=requisition.requisition_id&skimNdx=13&op=reset",
description: ""}) # no req, full time
EventTopic.create! event: bed_bath_and_beyond_manager, topic: job
EventTopic.create! event: bed_bath_and_beyond_manager, topic: no_diploma
EventTopic.create! event: bed_bath_and_beyond_manager, topic: full_time

marshalls_merchandising_development = Event.create!({name: "Marshall's Merchandising Development", 
url: "https://career8.successfactors.com/career?career_ns=job_listing&company=TJX&navBarLevel=JOB_SEARCH&rcm_site_locale=en_US&career_job_req_id=63701&selected_lang=en_US&jobAlertController_jobAlertId=&jobAlertController_jobAlertName=&_s.crb=jeMRIIQjJoUmj5pyJzqgKFPdhMU%3d",
description: "GPA requirement 3.0"}) # no req, full time
EventTopic.create! event: marshalls_merchandising_development, topic: job
EventTopic.create! event: marshalls_merchandising_development, topic: training
EventTopic.create! event: marshalls_merchandising_development, topic: no_diploma
EventTopic.create! event: marshalls_merchandising_development, topic: full_time

amc_film_crew = Event.create!({name: "AMC Film Crew", 
url: "https://sjobs.brassring.com/TGWebHost/jobdetails.aspx?SID=%5eRvnLQlU9TYFUGWjpWNbhUQby8tRIOIDB2R42o9PuXXH50PGFzQkuNTZQpBvcdKRn&jobId=351692&type=search&JobReqLang=1&recordstart=1&JobSiteId=5197&JobSiteInfo=351692_5197&GQId=795",
description: ""}) # no req, full time
EventTopic.create! event: amc_film_crew, topic: job
EventTopic.create! event: amc_film_crew, topic: no_diploma
EventTopic.create! event: amc_film_crew, topic: full_time
EventTopic.create! event: amc_film_crew, topic: part_time


resilient_coders = Event.create!({name: "Resilient Coders", 
url: "http://resilientcoders.org/",
description: "
Resilient Coders is a volunteer-based program focused on making web technology more available to urban youth who might not otherwise be exposed to it. It's a three-part program that funnels students from learning HTML after school, through our downtown \"Coworking\" sessions, and ultimately, hourly employment. Our higher performers participate in Resilient Lab, a web design and development shop with real clients."})
EventTopic.create! event: resilient_coders, topic: training

pipefitters = Event.create!({name: "Pipefitters 537 Apprenticeship", 
url: "http://www.pipefitters537.org/apprenticeship.aspx",
description: "
The UA offers a comprehensive training program for all members. Pipefitters Local 537 offers a five year Apprenticeship program at no cost to the selected candidates. Apprentices work in the field on a graduating wage scale during their apprenticeship while being educated at our Training Center weeknights during the school year, allowing them to learn while they earn. <Br>
On the job training with the best hands in the business means that at the end of your five years as an apprentice you will be a master craftsman/woman in the Pipefitting Business whether your path is of a Pipefitter, Welder or HVAC- Refrigeration Technician.<Br>
UA Local 537 members are found on all commercial and industrial projects including school construction jobs, powerhouses, chip-fab plants, hospitals and universities.<br>
Union benefits go beyond our excellent healthcare coverage and wages. As a union member your wages and benefits are guaranteed through the collective bargaining process.<br>
Many people don’t know that if you work without a contract in ANY INDUSTRY, your employer can change your job description at will. They can even change your salary or decide that you are not eligible for overtime pay.<br>
As a union member, your contract spells out your working conditions, which go far beyond your wages. Health and safety issues are clearly addressed in the contract, and you are provided with representation in the case that your rights are violated by an employer.<br>
"})
EventTopic.create! event: pipefitters, topic: training

ymca_office_skills = Event.create!({name: "YMCA Computerized Office Skills", 
url: "http://ymcaboston.org/traininginc/traininginc-programs-job-seekers",
description: "
YMCA Training, Inc.’s Computerized Office Skills is a 20-week, full-time professional training program.  Working in a business environment, participants gain office and computer skills that prepare them to thrive in skilled employment.
"})
EventTopic.create! event: ymca_office_skills, topic: training
