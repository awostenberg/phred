require 'rubygems'
require 'gosu'

class Player
	def initialize(window, type, spawn_x, spawn_y, dir)
		@window = window
		@type = type
		@image = Gosu::Image.new(@window, "images/entities/player" + @type.to_s + ".png", true)
		@x = spawn_x
		@y = spawn_y
		@y_vel = 0
		@dir = dir
		if type == 1
			@u_button = Gosu::Button::KbUp
			@d_button = Gosu::Button::KbDown
			@l_button = Gosu::Button::KbLeft
			@r_button = Gosu::Button::KbRight
		end
		
		if type == 2
			@u_button = Gosu::Button::KbW
			@d_button = Gosu::Button::KbS
			@l_button = Gosu::Button::KbA
			@r_button = Gosu::Button::KbD
		end
	end
	
	def update
		if button_down? @r_button
			@dir = 1
			@x = @x + 5
		end
		if button_down? @l_button
			@dir = 2
			@x = @x - 5
		end
		if button_down? @u_button
			@y_vel = 15
		end
		if button_down? @d_button
		end
		
		#-----------------
		#lock right/left
		#-----------------
		
		if @dir == 1
			@direction = 90		#right
		end
		if @dir == 2
			@direction = -90	#left
		end
		
		#-----------------
		#gravity
		#-----------------
		
		@y = @y - @y_vel
		if not (@y_vel < -30)
			@y_vel = @y_vel - 0.5
		end
		
	end
	
	def draw
		@image.draw_rot(@x + 5, @y + 5, 1, @direction)
		#@image.draw(@x, @y, 1)
	end
	
	def button_down?(id)
		@window.button_down?(id)
	end
end