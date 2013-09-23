#!/usr/bin/env ruby

# The meat of this section of the script is parseTasks. It steps through each line in the TaskPaper file(s) and either adds it to the parent element as a project, task, or note; or, if the indentation level has increased, it recursively calls itself again with the latest item as the new parent. And if the indentation level drops below the current recursion level, it returns to the caller.

require('./task.rb')

filename = ARGV[0]


File.open( filename ).each do |line|

	t = Task.new (line) #, [])
	#t.is_task? ? (puts "true"): (puts "false")
	#puts "topics: " + t.task_string.scan(/(?<!\w)#[\w()]+/).inspect
	tags = "tags: " + t.task_string.scan(/(?<!\w)@\w*\([^\)]*\)|(?<!\w)@\w*\b/).inspect
	puts "Raw Tags: " + tags



	#puts t.indent_level
	#puts line

end