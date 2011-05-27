require 'rubygems'
require 'gosu'
require 'gig'
require 'slider'

class WhirlyGigs < Gosu::Window
	def initialize
		super(1000, 1000, false)
		self.caption = 'WhirlyGigs'
		@l = Whirlygig.new(self, '1', nil)
		@m = Whirlygig.new(self, '2', @l)
		@s = Whirlygig.new(self, '3', @m)
		@sp = "images/sliders/"
		@slider1 = Slider.new(self, @l, 0, @sp + "1")
		@slider2 = Slider.new(self, @m, 350, @sp + "2")
		@slider3 = Slider.new(self, @s, 700, @sp + "3")
		@cursor = Cursor.new(self)
	end
	
	def update
		if button_down?(Gosu::Button::KbSpace)
			[@l, @s, @m].each {|each| each.reset}
		end
		
		[@l, @s, @m, @slider1, @slider2, @slider3, @cursor].each {|each| each.update}
	end
	
	def draw
		[@l, @s, @m, @slider1, @slider2, @slider3, @cursor].each {|each| each.draw}
	end
end

class Cursor
	def initialize(window)
		@window = window
		@image = Gosu::Image.new(@window, "images/Cursor.png", true)
		@x = 0
		@y = 0
	end
	
	def update
		@x = mouse_x
		@y = mouse_y
	end
	
	def draw
		@image.draw(@x, @y, 3)
	end
	
	def mouse_x
		@window.mouse_x
	end
	
	def mouse_y
		@window.mouse_y
	end
end

window = WhirlyGigs.new
window.show