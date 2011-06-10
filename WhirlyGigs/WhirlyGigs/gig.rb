require 'rubygems'
require 'gosu'
require 'line'

class Whirlygig
	def initialize(window, size, primary)
		@window = window
		@primary = primary
		@size = size
		@image = Gosu::Image.new(@window, ('images/' + size + '.png'), true)
		@x = 0
		@y = 0
		@theta = 0
		@speed = 0
		
		@hue = rand(255)
		@color = Gosu::Color.from_hsv(@hue, 50, 100)
		@lines = Array.new
		
		if @size == '1'
			@distance = 150
			#@speed = 6			#change @speed to set the speed at which I rotate my primary
		end
		
		if @size == '2'
			@distance = 150
			#@speed = -2			#change @speed to set the speed at which I rotate my primary
		end
		
		if @size == '3'
			@distance = 130
			#@speed = 8		#change @speed to set the speed at which I rotate my primary
		end
		
		#-----------------------------
		
		set_pos
		
	end
	
	def update
		@hue = @hue + 1
		@color = Gosu::Color.from_hsv(@hue, 0.5, 0.5)
		
		set_pos
		if @size == '3'
			@lines << Line.new(@old_x, @old_y, @color, @x, @y, @color, @window)
		end
	end
	
	def draw
		if @size == '3'
			@lines.each {|line| line.draw(500, 500)}
		end
		
			@image.draw((@x - (width / 2) + 500), (@y - (height / 2) + 500), 1)
	end
	
	def set_pos			#Sets my position WITHOUT adding a line.
		@old_x = @x
		@old_y = @y
		
		@x = (Math.cos(@theta * (3.14 / 180))) * @distance
		@y = (Math.sin(@theta * (3.14 / 180))) * @distance
		
		if (not (@primary == nil))
			@x = @primary.x + @x
			@y = @primary.y + @y
		end
		
		@theta = @theta + @speed
	end
	
	def width
		@image.width
	end
	
	def height
		@image.height
	end
	
	def x
		@x
	end
	
	def y
		@y
	end
	
	def draw_line(line)
		window.draw
	end
	
	def lines
		@lines
	end
	
	def size
		@size
	end
	
	def speed(int)
		@speed = int
	end
	
	def reset
		@hue = rand(255)
		@lines = Array.new
		@theta = 0
	end
end