require 'rubygems'
require 'gosu'

module Colonies
	class Cursor
		def initialize(window)
			@window = window
			@image = Gosu::Image.new(window, IMG_FOLDER + 'cursor.png')
			@x = 0
			@y = 0
			window.add_obj(self)
		end
		
		def update
			@x = mouse_x
			@y = mouse_y
		end
		
		def draw
			@image.draw(@x, @y, 5)
		end
		
		def mouse_x
			@window.mouse_x
		end
		
		def mouse_y
			@window.mouse_y
		end
	end
end