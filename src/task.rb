#!/usr/bin/env ruby

require('./tag.rb')


class Task
  attr_accessor :tags, :task_string, :raw_task_string
  attr_accessor :created_date, :start_date, :due_date
  #attr_accessor :is_project, :is_task
  attr_accessor :tree_node

  def initialize(raw_task_string_data="", task_tag_array=[])
    @raw_task_string = raw_task_string_data
    @tags = task_tag_array




    tag_strings = @raw_task_string.scan(/(?<!\w)@\w*\([^\)]*\)|(?<!\w)@\w*\b/)
    @task_string = @raw_task_string.gsub(/(?<!\w)@\w*\([^\)]*\)|(?<!\w)@\w*\b/, "").strip

   
    @is_task = @task_string.strip =~ /^-.*/
    @is_project = @task_string.strip =~ /.*:$/

    if is_task?
      @task_string = @task_string.strip[1..@task_string.length].strip
    end
   
    if is_project? 
      @task_string = @task_string.strip[0..@task_string.length-2].strip
    end


    # puts "Raw Task: " + @task_string
    # puts "Raw Tags: " + tag_strings.inspect 
    
    tag_strings.each do |tag_string|
      tag =  tag_string[/^[^\()]*/]
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

  end

  def to_s
    tags = ""
    tags = @tags.join(" ") if @tags.length > 0
    "#{@task_string} #{tags}"
  end

  def empty?
    @task_string.strip.empty?
  end

  def is_done?
    return_value = false
    tags.each do |tag| 
      return_value = return_value || (tag.tag.downcase == "@done")
    end
    if (tree_node and tree_node.parent)
     # puts "checking parent: #{tree_node.parent.name.tags} where #{tree_node.parent.name.is_done?}"
      return_value = return_value || tree_node.parent.name.is_done?
    end
    return return_value
  end

  def is_project?
    @is_project
  end

  def is_task?
    @is_task
  end

  def is_comment?
    !empty? && !is_task? && !is_project? 
  end 

  def indent_level
    @raw_task_string[/\A\t*/].size
  end


  def get_tasks_by_context(context)
    tasks = []
    @tree_node.select do |node|

      node.name.tags.select {|tag| tag == context}.length > 0
    end
    return tasks
  end

  def self.parse_file(filename)
    root_task = Task.new("ROOT:")
    root_node = Tree::TreeNode.new(root_task)
    root_task.tree_node = root_node
    self._recurse_tree(root_node, 0, File.open(filename))
    return root_node
  end


  def self._recurse_tree(parent, depth, file)
      last_line = file.gets
      while last_line do
        task =  Task.new(last_line)
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