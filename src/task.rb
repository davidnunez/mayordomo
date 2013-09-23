#!/usr/bin/env ruby

class Task
  attr_accessor :tags, :task_string

  def initialize(task_string_data="", task_tag_array=[])
    @task_string = task_string_data
    @tags = task_tag_array
  end

  def to_s
    tags = ""
    tags = @tags.join(" ") if @tags.length > 0
    "#{@task_string} #{tags}"
  end

  def empty?
    @task_string.strip.empty?
  end

  def is_project?
    @task_string.strip =~ /.*:$/
  end

  def is_task?
    @task_string.strip =~ /^-.*/
  end

  def is_comment?
    !empty? && !is_task? && !is_project? 
  end 

  def indent_level
    @task_string[/\A\t*/].size
  end

end