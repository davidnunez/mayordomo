#!/usr/bin/env ruby
require 'tree'

require_relative 'task'
require_relative 'tag'
require 'highline/import'


class String
  def to_bool
    return true if self.downcase =~ (/^(true|t|yes|y|1)$/i)
    return false if self.downcase.empty? || self =~ (/^(false|f|no|n|0)$/i)

    raise ArgumentError.new "invalid value: #{self}"
  end
end


filename = ARGV[0]

root_node = Task.parse_file(filename)

#root_node.print_tree
#root_node.each {|node|  puts node.name  if (node.name.is_a? Task and node.name.is_task? and !node.name.is_done?)}
#puts root_node.name.get_tasks_by_context('@process')

root_node.children.each do |node|
  puts '----------------------------------------------------------------'
  node.name.tree_node.each do |leaf|
    puts leaf.name.to_tp
  end
  puts '----------------------------------------------------------------'

  choose do |menu|
    menu.readline = true
    menu.layout = :one_line
    menu.choice(:trash) { puts 'DELETE' }
    menu.choice(:someday) { puts 'someday' }
    menu.choice(:reference) { puts 'REFERENCE' }
    menu.choice(:quit) {exit}
  end
  node.name.tags << Tag.new('@handled', nil)

  # puts node.name.to_tp

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