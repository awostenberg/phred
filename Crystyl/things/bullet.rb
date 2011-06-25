require 'rubygems'
require 'gosu'

module CrystylGame
	class Bullet
		def initialize(window, start_x, start_y, direction, type)
			@window = window
			@start_x = start_x
			@start_y = start_y
			@direction = direction
			load_stats
			@image = Gosu::Image.new(@window, "media/images/" + type.to_s + ".png", false)
			@x = @start_x
			@y = @start_y
			@rand = Gosu::random(-500, 500)
		end
		
		def update
			@x += (Math.cos((@direction + (interval * 20)) * (3.14 / 180))) * @speed
			@y += (Math.sin((@direction + (interval * 20)) * (3.14 / 180))) * @speed
		end
		
		def draw
			@image.draw_rot(@x, @y, 1, @direction)
		end
		
		def load_stats
			@speed = 5
			@damage = 5
		end
		
		def x
			@x
		end
		
		def y
			@y
		end
		
		def interval
			((Math.sin(milliseconds / 24)))
		end
		
		def milliseconds
			Gosu::milliseconds + @rand
		end
		
		def width
			@image.width
		end
		
		def height
			@image.height
		end
		
		def damage
			@damage
		end
	end
	
	class Weak_Bullet < Bullet
		def initialize(window, start_x, start_y, direction)
			super(window, start_x, start_y, direction, :weak_bullet)
		end
		
		def load_stats
			@speed = 10
			@damage = 5
		end
	end
end