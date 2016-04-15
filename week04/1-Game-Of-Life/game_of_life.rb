class Board
	include Enumerable

	def initialize *args
		@alive_cells = args.uniq
	end

	def each(&block)
		@alive_cells.each(&block)
	end

    def [](x,y)
    	@alive_cells.include? [x,y]
    end

    def neighbours_to_cell(x,y)
    	[ [x-1, y-1], [x, y-1], [x+1, y-1], [x+1, y], [x+1, y+1], [x, y+1], [x-1, y+1], [x-1, y] ]
    end

    def count_alive_neighbours(x,y)
    	neighbours_to_cell(x,y).count { |x,y| self[x,y] }
    end

    def next_generation
    	next_alive_gen =select {|x,y| count_alive_neighbours(x,y)==2 or count_alive_neighbours(x,y)==3}

    	each do |x,y|
    		next_alive_gen += neighbours_to_cell(x,y).select { |x,y| count_alive_neighbours(x,y) == 3 }
    	end

    	Board.new *next_alive_gen
    end
end

board = Board.new [1, 2], [1, 3], [1, 4]

next_gen = board.next_generation

p next_gen[1, 2] # false
p next_gen[0, 3] # true
p next_gen[2, 3] # true