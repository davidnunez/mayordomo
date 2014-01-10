#!/usr/bin/env ruby

require 'oauth2'
require 'chronic'
require 'google_calendar'
require 'active_support/time'

filename = ARGV[0]

cal_maintenance = Mayordomo::Calendar.instance.get_calendar_by_short_name("maintenance")
cal_dark        = Mayordomo::Calendar.instance.get_calendar_by_short_name("dark")

puts "Sleep Start time:"
start_time = $stdin.gets.chomp
puts "Sleep End time:"
end_time = $stdin.gets.chomp
puts "Out of Bed time:"
out_time = $stdin.gets.chomp

start_time[-5,1] = ' '
end_time[-5,1] = ' '
out_time[-5,1] = ' ' if out_time != nil


event = cal_maintenance.create_event do |e|
  e.title = "Sleep"
  e.start_time = Chronic.parse(start_time)
  e.end_time = Chronic.parse(end_time)
end
event = cal_dark.create_event do |e|
  e.title = "Awake in Bed"
  e.start_time = Chronic.parse(end_time)
  e.end_time = Chronic.parse(out_time)
end if out_time != nil

