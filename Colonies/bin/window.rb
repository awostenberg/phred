require 'rubygems'
require 'gosu'

											#I couldn't get require_relative working, so I have to use this ugly code
require (File.dirname(__FILE__) + '/cursor')
require (File.dirname(__FILE__) + '/camera')
require (File.dirname(__FILE__) + '/terrain/map')
require (File.dirname(__FILE__) + '/GUI/button')
											#The game module
module Colonies
											#This should be the path in which all the images are contained
	IMG_FOLDER = 'bin/media/images/'
	
	class GameWindow < Gosu::Window
		def self.open						#Create and open a new instance of myself
			self.new.show
		end
		
		
		def initialize
			super(1000, 1000, false)
											#This is where all the objects that have both a draw AND an update method are stored, otherwise they might get their own variable
			@objects = Array.new
											#Create a new cursor for this window. I don't need to add it to @objects here; it does that by itself
			Cursor.new(self)
											#Create a new camera for this window
			@camera = Camera.new(self)
											#Create a new map for this window
			@map = Map.new(self, @camera)
		end
		
		def update
											#Set the window title
			self.caption = ('Colonies					FPS: ' + (Gosu::fps).to_s)
											#Quit the game if escape key pressed
			if button_down?(Gosu::KbEscape)
				Process.exit
			end
											#It is assumed that each object in @objects has an update method		
			@objects.each {|each| each.update}
											#Note: none of the objects in the following array have a draw method. That is why they are not in @objects
			[@camera, @map].each {|each| each.update}	
		end
		
		def draw
											#It is assumed that each thing in @objects has a draw method
			@objects.each {|each| each.draw}
		end
		
		def add_obj(obj)
											#This is called by objects that want to add themselves to @objects
			@objects << obj
		end
		
		def scroll_x
			@camera.x
		end
		
		def scroll_y
			@camera.y
		end
	end
end