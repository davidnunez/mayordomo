#!/usr/bin/env ruby
require 'tree'

require('./task.rb')
require('./tag.rb')

filename = ARGV[0]

root_node = Task.parse_file(filename)

root_node.print_tree
root_node.each {|node|  puts node.name  if (node.name.is_a? Task and node.name.is_task? and !node.name.is_done?)}
puts root_node.name.get_tasks_by_context("@blah")