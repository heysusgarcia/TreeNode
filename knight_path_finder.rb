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

  def trace_path_back
    result = [self]
    until result.last.parent.nil?
      result << result.last.parent
    end
    result
  end
end

class KnightPathFinder
  def initialize
    @visited_positions = [[0,0]]
    @move_tree = self.build_move_tree
  end

  def self.valid_moves(pos)
    valid = []
    x, y = pos[0], pos[1]

    potential_moves = [ [x + 2, y +1], [x + 2, y -1], [ x - 2, y + 1],
                        [x - 2, y - 1], [ x + 1, y + 2], [ x + 1, y - 2 ],
                        [ x -1, y + 2], [ x - 1, y - 2] ]

    potential_moves.each do |el|
      if (0..8).include?(el[0]) && (0..8).include?(el[1])
        valid << el
      end

    end
    valid
  end

  def new_move_positions(pos)
    result = []
    self.class.valid_moves(pos).each do |el|
      result << el unless @visited_positions.include?(el)
    end
  end

  def build_move_tree
    move_tree = PolyTreeNode.new([0, 0])
    queue = [move_tree]
    until queue.empty?
      first_el = queue.shift
      move_pos = self.new_move_positions(first_el.value)
      move_pos.each do |pos|
        @visited_positions << pos
        new_move = PolyTreeNode.new(pos)
        new_move.parent = first_el
        queue << new_move
      end

    end
    move_tree
  end

  def find_path(pos)
    path = []
    path_ob = @move_tree.dfs(pos).trace_path_back
    path_ob.each do |el|
      path << el.value
    end
    path.reverse
  end

end
