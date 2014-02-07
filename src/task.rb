#!/usr/bin/env ruby

require_relative 'tag'

class Task
  attr_accessor :tags, :task_string, :raw_task_string
  attr_accessor :start_date, :end_date, :due_date, :duration
  attr_accessor :topics, :tree_node, :type
  attr_accessor :is_project, :is_task

  def initialize(raw_task_string_data='', task_tag_array=[], task_topic_array=[])
    @raw_task_string = raw_task_string_data
    @tags = task_tag_array
    @topics = task_topic_array

    tag_strings = @raw_task_string.scan(/(?<!\w)@\w*\([^\)]*\)|(?<!\w)@\w*\b/)
    topic_strings = @raw_task_string.scan(/(?<!\w)#\w*\([^\)]*\)|(?<!\w)#\w*\b/)

    @task_string = @raw_task_string.gsub(/(?<!\w)@\w*\([^\)]*\)|(?<!\w)@\w*\b/, '').strip
    @task_string = @task_string.gsub(/(?<!\w)#\w*\([^\)]*\)|(?<!\w)#\w*\b/, '').strip


    @is_project = @task_string.strip.end_with? ':'
    @is_task = @task_string.strip.start_with? '-'


    if is_task?
      @task_string = @task_string.strip[1..@task_string.length].strip
      splitline = @task_string.split('|')
      if splitline.length == 3
        created_date = splitline[0].strip
        created_date[-5, 1] = ' '

        @tags << Tag.new('@created', created_date)
        @tags << Tag.new('@type', splitline[1].strip)
        @task_string = splitline[2..splitline.length].join(' | ').strip
      end

    end

    if is_project?
      self.task_string = self.task_string.strip[0..self.task_string.length-2].strip
    end


    tag_strings.concat(topic_strings).each do |tag_string|
      tag = tag_string[/^[^\()]*/]
      value = nil
      if tag_string[/\(.*\)/]
        value = tag_string.scan(/\(([^\)]+)\)/).last.first
      end
      # puts "\tTag: " + tag 
      # if value 
      # puts "\t\tValue: " + value
      # end
      @tags << Tag.new(tag, value)

    end
    # puts "INDENT: " + self.indent_level.to_s
    # puts self.inspect
    # puts "DONE: " + self.done?.to_s
    # puts "--------------------------------"

    #if tag_strings.length > 0
    #  puts "Raw String : " + @raw_task_string
    #  puts "Task String: " + @task_string
    #  puts "Raw Tags   : " + tag_strings.inspect
    #end

  end

  def to_s
    tags = ''
    tags = @tags.join(' ') if @tags.length > 0
    "#{@task_string} #{tags}"
  end

  def to_tp
    tags = ''
    tags = @tags.join(' ') if @tags.length > 0

    return_string = "#{@task_string}"

    if is_task
      return_string = "- #{return_string}"
    end
    if is_project
      return_string = "#{return_string}:"
    end

    if tags.length > 0
      return_string = "#{return_string} #{tags}"
    end
    "#{"\t"*indent_level}#{return_string}"

  end

  def empty?
    @task_string.strip.empty?
  end

  #def is_done?
  #  return_value = false
  #  return_value || self.includes_tag?('done')
  #  #tags.each do |tag|
  #  #  return_value = return_value || (tag.tag.downcase == '@done')
  #  #end
  #  if tree_node and tree_node.parent
  #   # puts "checking parent: #{tree_node.parent.name.tags} where #{tree_node.parent.name.is_done?}"
  #    return_value = return_value || tree_node.parent.name.is_done?
  #  end
  #  return_value
  #end

  def is_project?
    @is_project
#    @task_string.strip.end_with? ':'
  end

  def is_task?
    @is_task
#    @task_string.strip.start_with? '-'
  end

  def is_comment?
    !self.empty? && !self.is_task? && !self.is_project?
  end

  def is_done?
    self.includes_tag?('done')
  end

  def created_date
    created_date = @tags.select { |tag| tag.tag.downcase.include?("@created") }
    if created_date.first
      created_date.first.value
    else
      nil
    end
  end

  def includes_tag?(_tag)
    (not @tags.select { |tag| tag.tag.downcase.include?(_tag) }.empty?)
  end

  def indent_level
    @raw_task_string[/\A\t*/].size
  end

  def get_tasks_by_context(context)
    self.tree_node.select do |node|
      node.name.tags.select { |tag| tag.tag == context }.length > 0
    end
  end

  def self.parse_file(filename)
    root_task = Task.new('ROOT:')
    root_node = Tree::TreeNode.new(root_task)
    root_task.tree_node = root_node
    self._recurse_tree(root_node, 0, File.open(filename))
    return root_node
  end


  def self._recurse_tree(parent, depth, file)
    last_line = file.gets
    while last_line do
      task = Task.new(last_line)
      tabs = task.indent_level
      if tabs < depth
        break
      end
      node = Tree::TreeNode.new(task)
      task.tree_node = node
      if tabs >= depth
        parent << node
        last_line = self._recurse_tree(node, task.indent_level+1, file)
      end
    end
    return last_line
  end
end