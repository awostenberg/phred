							#Load the tile class
require (File.dirname(__FILE__) + '/tile.rb')

module Colonies
	class Map
		def initialize(window, camera)
							#Initialize a few variables
			@window = window
			@camera = camera
			@tiles = Array.new
							#Create a new map
			generate_map(25, 25, 0, 0)
		end
		
		
		
		def generate_map(x_length, y_length, x_orgin, y_orgin)
							#Figure out how many tiles can fit inside the given rectangle
			$tiles_num = x_length * y_length
							#Set the starting point
			$x = x_orgin
			$y = y_orgin
			
							#Initialize the countdown, $cd_start may be any whole number
			$cd_start = 10
			$cd = $cd_start
			
							#Tile-generating loop. Only needs to repeat $tile_num times
			
			$tiles_num.times do |i|
							#Add a randomized tile at the correct position. It will probably be dirt
				#if (Gosu::random(0, 21)) < 2
				#	$type = 'rock'
				#else
				#	$type = 'dirt'
				#end
				
				@tiles << Tile.new(@window, @camera, 'dirt', $x, $y)
							#Change the x and y positions
				if $x >= (x_length - 1 + x_orgin)
					$y += 1
					$x = x_orgin
				else
					$x += 1
				end
				
						#If $tiles_num is 1, then just print 0. Otherwise it causes problems
				if $tiles_num == 1
					puts 0
				else
					if (i % ($tiles_num/($cd_start)) == 0)
								#Print the countdown
						print (($cd).to_s + '	')
						STDOUT.flush
						
						$cd -= 1
					end
				end
			end
			
			puts ''
		end
		
		
		
		def update
							#Call each and every tile's update method. I should be the only one to generate new tiles
			@tiles.each {|tile| tile.update}
		end
	end
end