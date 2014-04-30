#!/usr/bin/env ruby

require 'oauth2'
require 'chronic'
require 'google_calendar'
require 'active_support/time'
require_relative 'task'
require 'imdb'
require_relative 'calendar'

filename = ARGV[0]


cal_consumption = Mayordomo::Calendar.instance.get_calendar_by_short_name('consumption')
cal_maintainance = Mayordomo::Calendar.instance.get_calendar_by_short_name('maintainance')

text=File.open(filename).read
text.gsub!(/\r\n?/, "\n")

text.each_line do |line|
	puts "processing #{line}"
	task = Task.new(line)
	next if task.is_done?
	if task.includes_tag?('eca')
		cal_maintainance.create_event do |e|
		  e.title = "ECA"
		  begin
			  e.content = task.get_tag('eca').value
		  rescue
		  end
		  puts "ECA: #{task.created_date}"
		  e.start_time = Chronic.parse(task.created_date)
		  e.end_time = Chronic.parse(task.created_date)
		end		
	end
	if task.includes_tag?('movie') or task.includes_tag?('tv')
		puts '--------------'
		puts line
		i = Imdb::Search.new(task.task_string)
		i.movies[0..5].each_with_index do |movie, index|
			puts "#{index}: #{movie.title}"
		end

		selection = $stdin.gets.chomp
		puts selection
		if selection == 'm'
			i.movies[0..30].each_with_index do |movie, index|
				puts "#{index}: #{movie.title}"
			end
			selection = $stdin.gets.chomp
		end
		selection = selection.to_i

		season = nil
		if task.includes_tag?('tv')
			puts 'Season and Episode?'
			season = $stdin.gets.chomp
		end
		puts "Adding #{i.movies[selection].title} to calendar..."
		cal_consumption.create_event do |e|
		  e.title = i.movies[selection].title 
		  e.title = e.title + ' ' + season if season
		  e.content = i.movies[selection].id
		  e.start_time = Chronic.parse(task.created_date)
		  e.end_time = Chronic.parse(task.created_date) + i.movies[selection].length.to_i * 60
		end
	end
end