#!/usr/bin/env ruby
require 'tree'

require('./task.rb')
require('./tag.rb')


def _recurse_tree(parent, depth, file)
    last_line = file.gets
    while last_line do
    	task =  Task.new(last_line)
        tabs = task.indent_level
        if tabs < depth
            break
        end
        node = Tree::TreeNode.new(task.task_string, task)
        if tabs >= depth
            parent << node
            last_line = _recurse_tree(node, task.indent_level+1, file)
        end
    end	
    return last_line
end

filename = ARGV[0]
root_node = Tree::TreeNode.new("ROOT", "Root Content")
_recurse_tree(root_node, 0, File.open(filename))
root_node.print_tree