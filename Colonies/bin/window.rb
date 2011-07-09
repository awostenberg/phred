require 'rubygems'
require 'gosu'

											#I couldn't get require_relative working, so I have to use this ugly code x_x
require (File.dirname(__FILE__) + '/cursor.rb')
require (File.dirname(__FILE__) + '/camera.rb')
require (File.dirname(__FILE__) + '/terrain/tile.rb')
require (File.dirname(__FILE__) + '/terrain/map')

module Colonies
											#This should be the path in which all the images are contained
	IMG_FOLDER = 'bin/media/images/'
	
	class GameWindow < Gosu::Window
		def self.open						#Create and open a new instance of myself
			self.new.show
		end
		
		
		def initialize
			super(1000, 1000, false)
			self.caption = 'Colonies'
											#This is where all the objects that have both a draw AND an update method are stored, otherwise they might get their own variable
			@objects = Array.new
											#Create a new cursor for this window. I don't need to add it to @objects here; it does that by itself
			Cursor.new(self)
											#Create a new camera for this window
			@camera = Camera.new(self)
											#Create a new map for this window
			@map = Map.new(self, @camera)
			#Tile.new(self, 'grass', 0, 0)
			#Tile.new(self, 'grass', 40, 0)
			#Tile.new(self, 'grass', 0, 40)
			#Tile.new(self, 'grass', 40, 40)
		end
		
		def update
											#It is assumed that each object in @objects has an update method		
			@objects.each {|each| each.update}
											#Note: none of the objects in the following array have a draw method. That is why they are not in @objects
			[@camera, @map].each {|each| each.update}	
			
			#puts ('Camera x position: ' + (@camera.x).to_s)
			#puts ('Camera y position: ' + (@camera.y).to_s)
			#puts '----------'
		end
		
		def draw
											#It is assumed that each thing in @objects has a draw method
			@objects.each {|each| each.draw}
		end
		
		def add_obj(obj)
											#This is called by objects that want to add themselves to @objects
			@objects << obj
		end
	end
end