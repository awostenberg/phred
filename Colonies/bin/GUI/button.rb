require 'rubygems'
require 'gosu'

module Colonies
	class Button			#A basic button class
		def initialize(window, x, y)
			@window = window
			@x = x
			@y = y
							#Set the path to the button folder
			$path = IMG_FOLDER + 'GUI/buttons/'
							#Initialize the 3 images
			@off = Gosu::Image.new(window, $path + 'frame_off.png', true)
			@down = Gosu::Image.new(window, $path + 'frame_down.png', true)
			@over = Gosu::Image.new(window, $path + 'frame_over.png', true)
							#Add this button to the window so it can draw
			@window.add_obj(self)
							#Initialize the image
			@image = @off
		end
		
		def update
			if mouse_in_bounds?
				if r_mouse_down?
					@image = @down
				else
					@image = @over
				end
			else
				@image = @off
			end
		end
		
		def draw
			@image.draw(@x, @y, 4)
		end
		
		def mouse_in_bounds?
			((mouse_x > x) and (mouse_x < (x + @image.width))) and ((mouse_y > y) and (mouse_y < (y + @image.height)))
		end
		
		def x
			@x
		end
		
		def y
			@y
		end
		
		def set_x(new)
			@x = new
		end
		
		def set_y(new)
			@y = new
		end
		
		def mouse_x
			@window.mouse_x
		end
		
		def mouse_y
			@window.mouse_y
		end
		
		def r_mouse_down?
			@window.button_down?(Gosu::MsLeft)
		end
	end
end