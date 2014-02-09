#!/usr/bin/env ruby
require 'tree'

require_relative 'task'
require_relative 'tag'
require 'highline/import'
require 'pathname'

require 'parseconfig'
require 'fileutils'
require 'time'
class String
  def to_bool
    return true if self.downcase =~ (/^(true|t|yes|y|1)$/i)
    return false if self.downcase.empty? || self =~ (/^(false|f|no|n|0)$/i)

    raise ArgumentError.new "invalid value: #{self}"
  end
end


def prepend(filename, prepend_text)
  original_file = filename
  new_file = original_file + '.new'

  File.open(new_file, 'w') do |fo|
    fo.puts prepend_text
    File.foreach(original_file) do |li|
      fo.puts li
    end
  end

  File.rename(original_file, original_file + '.old')
  File.rename(new_file, original_file)
end


@config = ParseConfig.new('main.config')

filename = ARGV[0]

file_old = FileUtils.copy(filename, "#{filename}.#{DateTime.now.strftime("%Y-%m-%d-%H%M")}.bak")
file_new = File.new("#{filename}.new", "w")

root_node = Task.parse_file(filename)

#root_node.print_tree
#root_node.each {|node|  puts node.name  if (node.name.is_a? Task and node.name.is_task? and !node.name.is_done?)}
#puts root_node.name.get_tasks_by_context('@process')

skipping = false

root_node.children.each do |node|
  if !node.name.is_done? and !skipping
    puts '----------------------------------------------------------------'
    puts node.name.to_full_tp
    puts '----------------------------------------------------------------'

    choose do |menu|
      menu.readline = true
      menu.layout = :one_line
      menu.choice(:trash) do
        node.name.tags << Tag.new('@wontdo', nil)
        node.name.tags << Tag.new('@done', nil)
      end
      menu.choice(:move) do |s|
        # puts node.name.tags
        topic = ask('Topic?  ')
        files = Dir.glob("#{@config['BRAIN_DIRECTORY']}/*#{topic}*")

        someday_file = choose { |file|
          file.choice(:skip) { nil }
          files.each { |f| file.choice(f) }
        }
        if someday_file
          File.open(someday_file, 'a') { |f| f.write(node.name.to_full_tp) }
          node.name.tags << Tag.new('@txfr', nil)
          node.name.tags << Tag.new('@done', nil)
        end

      end
      menu.choice(:do) do
        node.name.tags << Tag.new('@done', nil)
      end
      menu.choice(:add_to_gtdx) do
        prepend("#{@config['BRAIN_DIRECTORY']}/gtdx.txt", node.name.to_full_tp)
        node.name.tags << Tag.new('@txfr', nil)
        node.name.tags << Tag.new('@done', nil)
      end
      menu.choice(:quit) {skipping = true}
    end
  end
  file_new.write(node.name.to_full_tp)
end

FileUtils.move(file_new.path, filename)

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