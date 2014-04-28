require 'mongoid'
module Mayordomo
	class Event
		include Mongoid::Document
	  	field :title,    type: String
	  	field :content,    type: String
	  	field :start_time, type: Time
	  	field :end_time, type: Time
	end
end