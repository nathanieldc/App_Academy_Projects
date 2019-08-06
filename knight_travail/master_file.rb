require_relative "00_tree_node.rb"
require "byebug"


class KnightPathFinder
    KNIGHT_MOVES = [[2,1],    ## All potentail moves that can be made, at a position. 
                    [2,-1],
                    [-2,1],
                    [-2,-1],
                    [1,2],
                    [1,-2],
                    [-1,2],
                    [-1,-2] ]

    attr_accessor :root_node, :considered_positions
    
    def initialize(start_pos)                             ##recieves the start position; root of tree
        self.root_node = PolyTreeNode.new(start_pos)      ##the root of the tree; parent = nil, value is start-pos, and children = []
        @considered_positions = [start_pos]               ## [start-pos]
        build_move_tree                                   ## ???
    end

    def build_move_tree                                   ##
        nodes = [self.root_node] 
            until nodes.empty?
            nodes_children = new_move_positions(nodes.first.value)
            nodes += nodes_children.map! { |pos| PolyTreeNode.new(pos) }
            print nodes.first
            nodes.shift 
            end
    end

    def self.valid_moves(pos)                             ## Will return an array of all valid potential moves
        valid_moves = []
        board_borders = (0..7).to_a
        row_p, col_p = pos
        
        KNIGHT_MOVES.each do |move|
            row_m, col_m = move
            row_sum = (row_p + row_m)
            col_sum = (col_p + col_m)
            valid_moves << [row_sum, col_sum] if board_borders.include?(row_sum) && board_borders.include?(col_sum)
        end
        valid_moves 
    end

    def new_move_positions(pos)                           ## Returns an array
        new_valid = KnightPathFinder.valid_moves(pos).reject { |move| @considered_positions.include?(move)}
      
        new_valid.each do |move|
            @considered_positions << move
        end
        new_valid
    end

end