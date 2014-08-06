class PolyTreeNode
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end
  
  def parent 
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value 
  end
  
  def parent=(newparent) 
    @parent.children.delete(self) unless @parent.nil? 
    @parent = newparent
    newparent.children << self unless @parent.nil?
  end 
  
  def add_child(child_node)
    child_node.parent=(self)
  end
  
  def remove_child(child)
    child.parent = nil
    @children.delete(child)
  end
  
  def dfs(value)
    if self.value == value
      return self        
    elsif !@children.empty?  
      @children.each do |element|
        result = element.dfs(value)
        return result unless result.nil?
      end
    end
    nil
  end
  
  def bfs(value)
    queue = [self]
    until queue.empty?
      first_el = queue.shift  
      if first_el.value == value
        return first_el
      elsif !first_el.children.empty?
        first_el.children.each do |element|
          queue << element  
        end
      end
    nil
    end
  end
  
end

