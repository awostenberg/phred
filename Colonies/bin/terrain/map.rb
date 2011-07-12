require (File.dirname(__FILE__) + '/tile.rb')

module Colonies
	class Map
		def initialize(window, camera)
			@window = window
			@camera = camera
			@tiles = Array.new
			generate_map(625)
		end
		
		def generate_map(tiles)
			$nsqrt = (Math.sqrt(tiles)).to_i
			tiles.times do |i|
				$x = i % $nsqrt
				$y = i / $nsqrt
				if (Gosu::random(1, 101) < 99)
					@tiles << Tile.new(@window, 'dirt', $x, $y)
				else
					@tiles <<Tile.new(@window, 'rock', $x, $y)
				end
			end
		end
		
		def update
			$scroll_x = @camera.x
			$scroll_y = @camera.y
			@tiles.each {|tile| tile.set_x_offset(-$scroll_x)
								tile.set_y_offset(-$scroll_y)}
		end
	end
end