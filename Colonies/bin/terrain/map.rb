require (File.dirname(__FILE__) + '/tile.rb')

module Colonies
	class Map
		def initialize(window, camera)
			@window = window
			@camera = camera
			@tiles = Array.new
			initialize_tiles
		end
		
		def initialize_tiles
			@tiles << Tile.new(@window, 'dirt', -120, 80)
			@tiles << Tile.new(@window, 'dirt', -40, -40)
			@tiles << Tile.new(@window, 'dirt', 0, -40)
			@tiles << Tile.new(@window, 'dirt', -40, 0)
			@tiles << Tile.new(@window, 'dirt', 0, 0)
			@tiles << Tile.new(@window, 'dirt', 40, 0)
			@tiles << Tile.new(@window, 'dirt', 0, 40)
			@tiles << Tile.new(@window, 'dirt', 80, 80)
		end
		
		def update
			$scroll_x = @camera.x
			$scroll_y = @camera.y
			@tiles.each {|tile| tile.set_x_offset(-$scroll_x)
								tile.set_y_offset(-$scroll_y)}
		end
	end
end