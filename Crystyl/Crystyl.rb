#!/usr/bin/env ruby

require 'rubygems'
require 'gosu'
require 'things/crystyl'
require 'things/player'
require 'things/bullet'

module CrystylGame
	class GameWindow < Gosu::Window
		def self.open
			self.new.show
		end
		
		def initialize
			super(1000, 1000, false)
			self.caption = "Crystyl"
			@cursor = Cursor.new(self)
			@bullets = Array.new
			@objects = Array.new
			@objects << @cursor
			@objects << Player.new(self, 1)
			@objects << Player.new(self, 2)
			@objects << @bullets
		end
		
		def update
			@objects.flatten.each {|each| each.update}
		end
		
		def draw
			@objects.flatten.each {|each| each.draw}
		end
		
		def quit
			Process.exit
		end
		
		def bullets
			@bullets
		end
		
		def delete(obj)
			@objects.delete(obj)
		end
	end
	
	class Cursor
		def initialize(window)
			@window = window
			@image = Gosu::Image.new(@window, "media/images/cursor.png", false)
			@x = 0
			@y = 0
		end
		
		def update
			@x = mouse_x
			@y = mouse_y
		end
		
		def draw
			@image.draw(@x, @y, 4)
		end
	
		def mouse_x
			@window.mouse_x
		end
		
		def mouse_y
			@window.mouse_y
		end
	end
end

CrystylGame::GameWindow.open