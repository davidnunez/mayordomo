require 'chronic'
require 'google_calendar'
require 'active_support/time'


module Mayordomo
	class Calendar
		include Singleton
		config = ParseConfig.new('main.config')
		def maintenance
			if @cal_maintenance == nil
				@cal_maintenance = generate_calendar('z qs maintenance')
			end
			return @cal_maintenance
		end

		def consumption
			if @cal_consumption == nil
				@cal_consumption = generate_calendar('z qs consumption')
			end
			return @cal_consumption
		end

		def moves_places
			if @cal_moves_places == nil
				@cal_moves_places = generate_calendar('z qs moves places')
			end
			return @cal_moves_places
		end

		def moves_travel
			if @cal_moves_travel == nil
				@cal_moves_travel = generate_calendar('z qs moves travel')
			end
			return @cal_moves_travel
		end
		def generate_calendar(_calendar)
			config = ParseConfig.new('main.config')

			return Google::Calendar.new(:username => config['CALENDAR_USERNAME'],
				:password => config['CALENDAR_PASSWORD'],
				:app_name => config['CALENDAR_APP_NAME'],
				:calendar => _calendar)
		end

	end
end