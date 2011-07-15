require 'rubygems'
require 'gosu'

module Colonies
	class Cursor	#The, well... cursor
		def initialize(window)
			@window = window
					#Set my image. IMG_FOLDER is defined in window.rb
			@image = Gosu::Image.new(window, IMG_FOLDER + 'cursor.png')
			@x = 0
			@y = 0
					#Add me to the window so I can draw
			window.add_obj(self)
		end
		
		def update
					#Glue me to the mouse
			@x = mouse_x
			@y = mouse_y
		end
		
		def draw
					#Draw my image
			@image.draw(@x, @y, 5)
		end
		
		def mouse_x
			@window.mouse_x
		end
		
		def mouse_y
			@window.mouse_y
		end
	end
end