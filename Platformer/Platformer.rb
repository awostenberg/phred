require 'rubygems'
require 'gosu'
require 'player'
require 'terrain'

class GameWindow < Gosu::Window
	def initialize
		super(1000, 1000, false)
		self.caption = "Platformer"
		@cursor = Cursor.new(self)
		@player1 = Player.new(self, 1, width - 10, 0, 2)
		@player2 = Player.new(self, 2, 0, 0, 1)
		@terrain = Terrain.new(self)
	end
	
	def self.open
		self.new.show
	end
	
	def update
		@cursor.update
		@player1.update
		@player2.update
	end
	
	def draw
		@cursor.draw
		@player1.draw
		@player2.draw
	end
end

class Cursor
	def initialize(window)
		@window = window
		@image = Gosu::Image.new(@window, "images/cursor.png", true)
		@x = 0
		@y = 0
	end
	
	def update
		@x = mouse_x
		@y = mouse_y
	end
	
	def draw
		@image.draw(@x, @y, 2)
	end
	
	def mouse_x
		@window.mouse_x
	end
	
	def mouse_y
		@window.mouse_y
	end
end

GameWindow.open