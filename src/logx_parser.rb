#!/usr/bin/env ruby

require 'oauth2'
require 'chronic'
require 'google_calendar'
require 'active_support/time'
require ('./task.rb')
require 'imdb'
require './calendar.rb'

filename = ARGV[0]


cal_consumption = Mayordomo::Calendar.instance.get_calendar_by_short_name("consumption")


text=File.open(filename).read
text.gsub!(/\r\n?/, "\n")

text.each_line do |line|
	task = Task.new(line)
	next if task.is_done?
	if task.includes_tag?("movie") or task.includes_tag?("tv")
		puts "--------------"
		puts line
		i = Imdb::Search.new(task.title)
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
		if task.includes_tag?("tv")
			puts "Season and Episode?"
			season = $stdin.gets.chomp
		end
		puts "Adding #{i.movies[selection].title} to calendar..."
		event = cal_consumption.create_event do |e|
		  e.title = i.movies[selection].title 
		  e.title = e.title + " " + season if season
		  e.content = i.movies[selection].id
		  e.start_time = Chronic.parse(task.creation_date)
		  e.end_time = Chronic.parse(task.creation_date) + i.movies[selection].length.to_i * 60
		end
	end
end