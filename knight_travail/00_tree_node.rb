class PolyTreeNode

   attr_reader :value, :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(p_node)
        @parent.nil? ? (@parent = p_node) : (@parent.children.delete(self) && @parent = p_node) 
        if self.parent == nil
            @parent = nil
        elsif !p_node.children.include?(self) 
            p_node.children << self
        end
    end

    def add_child(child)
        child.parent=(self)
    end
   
    def remove_child(child)
        raise "error" if child.parent.nil?
        child.parent=(nil)
    end

    def dfs(target_value)
        return self if self.value == target_value
        
        self.children.each do |child|
           result = child.dfs(target_value)
           return result unless result.nil?
        end
        nil
    end

    def bfs(target_value)
        nodes = [self]
        until nodes.first.value == target_value 
            nodes += nodes.first.children 
            nodes.shift 
            if nodes.length == 0
                return nil
            end
        end
        nodes.first
    end
end

 
    