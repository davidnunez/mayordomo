#!/usr/bin/env ruby

class Tag
  attr_accessor :tag, :value

  def initialize(tag_data="", value_data="")
    @tag= tag_data
    @value = value_data
  end

  def to_s
  	s = @tag.to_s
  	if (@value)
  		s = "#{s}(#{@value})"
  	end
  	return s
  end
end