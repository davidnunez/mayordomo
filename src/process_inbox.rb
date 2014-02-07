#!/usr/bin/env ruby
require 'tree'

require_relative 'task'
require_relative 'tag'

filename = ARGV[0]

root_node = Task.parse_file(filename)

#root_node.print_tree
#root_node.each {|node|  puts node.name  if (node.name.is_a? Task and node.name.is_task? and !node.name.is_done?)}
#puts root_node.name.get_tasks_by_context('@process')

root_node.children.each do |node|
  puts node.name.to_tp

end

#text=File.open(filename).read
#text.gsub!(/\r\n?/, "\n")
#
#text.each_line do |line|
#  puts "processing #{line}"
#  task = Task.new(line)
#  next if task.is_done?
#  if task.title
#    puts task.to_s
#    puts 'HERE: ' + task.title + " @created(#{task.created_date})"
#  end
#end