require 'rubygems'
require 'gosu'

class Line
	def initialize(x1, y1, c1, x2, y2, c2, window)
		@x1 = x1
		@y1 = y1
		@c1 = c1
		@x2 = x2
		@y2 = y2
		@c2 = c2
		@window = window
	end
	
	def draw(x_offset = 0, y_offset = 0)
		@window.draw_line(@x1 + x_offset, @y1 + y_offset, @c1, @x2 + x_offset, @y2 + y_offset, @c2)
	end
end