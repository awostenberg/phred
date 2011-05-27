require 'rubygems'
require 'gosu'

class Slider
	def initialize(window, whirlygig, x_pos, image_folder)
		@window = window
		@whirlygig = whirlygig
		@body = Gosu::Image.new(@window, image_folder + "/body.png", true)
		@grip = Gosu::Image.new(@window, image_folder + "/grip.png", true)
		@font = 'fonts/Apple Chancery.ttf'
		@title = Gosu::Font.new(@window, @font, 50)
		@text = Gosu::Font.new(@window, @font, 50)
		@x = x_pos
		@y = 950
		@grip_x = @body.width / 2
		@grip_y = (@body.height / 2 - (@grip.height / 2))
		@dragging = false
		@name = @whirlygig.size
	end
	
	def update
		if (button_down?(Gosu::MsLeft) and (touching_mouse?))
			@dragging = true
		end
		
		if not (button_down?(Gosu::MsLeft))
			@dragging = false
		end
		
		if @dragging
			if @grip_x < 0
				@grip_x = -1
			else
				if @grip_x > @body.width - 10
					@grip_x = @body.width - 9
				else
					@grip_x = mouse_x - @x
				end
			end
		end
		
		if ((@grip_x < -0) or (@grip_x > @body.width - 10))
			@grip_x = mouse_x - @x
		end
		
		@whirlygig.speed(value)
	end
	
	def draw
		@body.draw(@x, @y, 0)
		if not ((@grip_x < -1) or (@grip_x > @body.width - 10))
			@grip.draw(@x + @grip_x, @y + @grip_y, 1)
		end
		@title.draw(@whirlygig.size + ' speed', @x + (@body.width / 2) - 50, @y - 20, 2)
		@text.draw(value, @x + (@body.width / 2) - 10, @y - 20 + 25, 2)
	end
	
	def mouse_x
		@window.mouse_x
	end
	
	def mouse_y
		@window.mouse_y
	end
	
	def mouse_up?
		@window.button_up(Gosu::MsLeft)
	end
	
	def touching_mouse?
		d = (Gosu::distance(@x + @grip_x + 5, @y + @grip_y + 5, mouse_x, mouse_y))
		touching = d < (@grip.width)
		touching
	end
	
	def button_down?(id)
		@window.button_down?(id)
	end
	
	def value
		((@grip_x - (@body.width / 2)) / 5).round
	end
end