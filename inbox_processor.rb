#!/usr/bin/env ruby

filename = ARGV[0]


File.open( filename ).each do |line|
	if line.start_with('-')
		print line
	end
end
