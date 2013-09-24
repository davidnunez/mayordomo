#!/usr/bin/env ruby

require('./tag.rb')


class Task
  attr_accessor :tags, :task_string, :raw_task_string
  attr_accessor :created_date, :start_date, :due_date

  def initialize(raw_task_string_data="", task_tag_array=[])
    @raw_task_string = raw_task_string_data
    @tags = task_tag_array




    tag_strings = @raw_task_string.scan(/(?<!\w)@\w*\([^\)]*\)|(?<!\w)@\w*\b/)
    @task_string = @raw_task_string.gsub(/(?<!\w)@\w*\([^\)]*\)|(?<!\w)@\w*\b/, "").strip

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

  def done?
    return_value = false
    tags.each do |tag| 
      return_value = return_value || (tag.tag.downcase == "@done")
    end
    return return_value
  end



  def is_project?
    @raw_task_string.strip =~ /.*:$/
  end

  def is_task?
    @raw_task_string.strip =~ /^-.*/
  end

  def is_comment?
    !empty? && !is_task? && !is_project? 
  end 

  def indent_level
    @raw_task_string[/\A\t*/].size
  end

end