# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end


# fetches list of agencies from usa.gov API 
puts 'AGENCIES'
agency_url = 'http://www.usa.gov/api/USAGovAPI/contacts.json/contacts?result_filter=Id|Name|parent|synonym|language&sort=name&query_filter=language::en'
puts "fetching agency list from: #{agency_url}"
agency_tree = HTTParty.get(URI.encode(agency_url), headers: {'Content-Type' => 'application/json'})
agency_names = agency_tree['Contact'].map{|c| c['Name']}.sort()
agency_names.each { |agency| Agency.find_or_create_by_name(:name => agency); puts 'agency: ' << agency }
