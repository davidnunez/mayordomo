require 'chronic'
require 'google_calendar'
require 'active_support/time'
require 'parseconfig'
require 'singleton'
module Mayordomo
	class Calendar
		include Singleton
		attr_accessor :short_names, :config

		def get_calendar_by_short_name(_short_name)
			return get_calendar(@short_names[_short_name])
		end

		def get_calendar(_calendar)
			return @calendars[_calendar] if @calendars.has_key?(_calendar)
			@calendars[_calendar] = Google::Calendar.new(:username => @config['CALENDAR_USERNAME'],
				:password => @config['CALENDAR_PASSWORD'],
				:app_name => @config['CALENDAR_APP_NAME'],
				:calendar => _calendar)
			return @calendars[_calendar]
		end
		def initialize
			@config = ParseConfig.new('main.config')
			@short_names = Hash[
					"maintenance"  => @config['CALENDAR_NAME_MAINTENANCE'],
					"consumption"  => @config['CALENDAR_NAME_CONSUMPTION'],
					"moves_places" => @config['CALENDAR_NAME_MOVES_PLACES'],
					"moves_travel" => @config['CALENDAR_NAME_MOVES_TRAVEL'],
					"dark"         => @config['CALENDAR_NAME_DARK'],
				]
			@calendars = Hash.new
		end

	end
end