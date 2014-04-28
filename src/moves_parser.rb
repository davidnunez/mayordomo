#!/usr/bin/env ruby

require 'moves'
require 'oauth2'
require 'chronic'
require 'google_calendar'
require 'active_support/time'
require './calendar.rb'
require './event.rb'
require 'parseconfig'
require 'mongoid'
def moves_time(_time)
	_time.gsub!(/[TZ]/, '')    

	_time = _time.insert 4, '-'
	_time = _time.insert 7, '-'
	_time = _time.insert 10, ' '
	#puts _time
	Time.zone = "UTC"
	Chronic.time_class = Time.zone
	Chronic.parse(_time)

end

@config = ParseConfig.new('main.config')
auth_client = OAuth2::Client.new(@config['MOVES']['CLIENT_ID'], @config['MOVES']['CLIENT_SECRET'], :site => 'https://api.moves-app.com/',  :token_url => 'https://api.moves-app.com/oauth/v1/access_token', :authorize_url => 'https://api.moves-app.com/oauth/v1/authorize')
Mongoid.load!("./mongoid.yml", :development)


# puts
# puts "We will now open an authorization page in your default web browser. Copy the code you receive and return here."
# print "Press Enter to continue..."
# gets
# puts auth_client.auth_code.authorize_url(:scope => 'activity')
# %x{open "#{auth_client.auth_code.authorize_url(:scope => 'activity+location')}"}
# print "Paste the code you received here: "
# code = gets.strip
# puts code
# token = auth_client.auth_code.get_token(code)
# puts token.inspect # THIS TOKEN GOES IN config["moves_token"]

client =  Moves::Client.new(@config['MOVES']['TOKEN'])

puts client.profile

summary = client.daily_storyline(ARGV[0]) 
segments = summary[0]["segments"]

cal_places = Mayordomo::Calendar.instance.get_calendar_by_short_name("moves_places")
cal_travel = Mayordomo::Calendar.instance.get_calendar_by_short_name("moves_travel")


segments.each do |segment| 
	if segment["type"] == "place" 
		puts segment
		event = cal_places.create_event do |e|
		  e.title = segment["place"]["name"]
		  e.content = segment.to_s
		  e.start_time = (Time.parse(segment["startTime"]))
		  e.end_time = (Time.parse(segment["endTime"]))
		  Mayordomo::Event.create(title: e.title, content: e.content, start_time: e.start_time, end_time: e.end_time)
		end
	end
	if segment["type"] == "move" 
		puts segment
		event = cal_travel.create_event do |e|
		  e.title = "travel"
		  e.content = segment.to_s
		  e.start_time = (Time.parse(segment["startTime"]))
		  e.end_time = (Time.parse(segment["endTime"]))
		  Mayordomo::Event.create(title: e.title, content: e.content, start_time: e.start_time, end_time: e.end_time)
		  
		end

	end
end


