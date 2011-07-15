require 'rubygems'
require 'gosu'

module Colonies
	class Tile
		
		def initialize(window, camera, type, x, y)
			@window = window
			@camera = camera
			@type = type
			@x = x
			@y = y
			@image = Gosu::Image.new(@window, IMG_FOLDER + 'textures/' + @type + '/' + @type + ((Gosu::random(1, 5)).to_i).to_s + '.png', true)
					#Used for zooming
			@size = 2
					#Add me to the window so I can draw
			window.add_obj(self)
		end
		
		def update
			@size = @camera.zoom
		end
		
		def draw
					#Draw my image at an offet (scroll_x and scroll_y).
					#Also multiply my x and y by @image.width and @image.height (should == 40), because my x and y are in terms of a grid. EG: if x == 1 then draw at 40. if x == 4 then draw at 160 and so on
			@image.draw_rot((@x * width) + -scroll_x + (width / 2), (@y * height) + -scroll_y + (height / 2), 0, 0, 0.5, 0.5, @size, @size)
		end
		
		def scroll_x
			@camera.x
		end
		
		def scroll_y
			@camera.y
		end
		
		def width
			@image.width * @size
		end
		
		def height
			@image.height * @size
		end
	end
end