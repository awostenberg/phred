require 'rubygems'
require 'gosu'

module Colonies
	class Tile
		def initialize(window, type, x, y)
			@window = window
			@type = type
			@x = x
			@y = y
			@image = Gosu::Image.new(@window, IMG_FOLDER + @type + '/' + @type + ((Gosu::random(1, 5)).to_i).to_s + '.png', true)
			@x_offset = 0
			@y_offset = 0
			window.add_obj(self)
		end
		
		def update
		end
		
		def draw
			@image.draw(@x + @x_offset, @y + @y_offset, 1)
		end
		
		def set_x_offset(new)
			@x_offset = new
		end
		
		def set_y_offset(new)
			@y_offset = new
		end
	end
end