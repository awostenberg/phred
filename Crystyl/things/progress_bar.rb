require 'rubygems'
require 'gosu'

module CrystylGame
	Red = Gosu::Color.rgb(255, 0, 0)
	class Progress_Bar
		def initialize(window, obj, value_call)
			@window = window
			@value_call = value_call
			@obj = obj
			@type = obj.type
			@width = 101
			@height = 10
			@y = @window.height - @height
			
			if @type == 1
				@x = 0
			end
			if @type == 2
				@x = @window.width - @width
			end
		end
		
		def update
		end
		
		def draw
			draw_rect(@x, @y,  @x, @window.height,  @x + @width, @y,  @x + @width, @window.height, Gosu::Color.rgb(0, 255, 255))
			draw_rect(@x + 1, @y + 1,  @x + 1, @window.height - 1,  @x + @width - 1, @y + 1,  @x + @width - 1, @window.height - 1, Gosu::Color.rgb(0, 100, 100))
			draw_rect(@x + 1, @y + 1,  @x + 1, @window.height - 1,  @x + value, @y + 1,  @x + value, @window.height - 1, Gosu::Color.rgb(255, 0, 0))
		end
		
		def draw_line(x1, y1, x2, y2, c)
			@window.draw_line(x1, y1, c, x2, y2, c, 1)
		end
		
		def draw_rect(x1, y1, x2, y2, x3, y3, x4, y4, c)
			@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 1)
		end
		
		def value
			@obj.send(@value_call)
		end
	end
end