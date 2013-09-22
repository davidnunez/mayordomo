#!/usr/bin/env ruby

require "shellwords"

filename = ARGV[0]

def add_task (task, note)
	cmd = "~/projects/OTask/bin/otask #{task.shellescape}"
	if note != ""
		cmd = "echo #{note.shellescape} | " + cmd
	end
	system(cmd)
end


task = ""
note = ""
File.open( filename ).each do |line|
	if line.start_with?('-')
		if task != ""
			add_task(task, note)
			task = ""
			note = ""
		end

		line[0..1] = '' 
		splitline = line.split('|')
		creation_date = splitline[0]
		type = splitline[1] 
		title = splitline[2..splitline.length].join(' | ') 
		creation_date.strip!
		creation_date[-5,1] = ' '
		task = (title.strip! + " c(#{creation_date})")
	else
		note += line
	end
end

add_task(task, note)

