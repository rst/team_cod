# Load Rails
ENV['RAILS_ENV'] = 'development'
DIR = File.dirname(__FILE__)
require DIR + '/config/environment'

Importer.load_file('full_time.yml')
Importer.load_file('part_time.yml')
