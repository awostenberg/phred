module Colonies
	class Camera
		def initialize(window)
			@window = window
			@scroll_speed = 5
			@x = 0
			@y = 0
		end
		
		def update
			if button_down?(Gosu::KbUp)
				@y -= @scroll_speed
			end
			if button_down?(Gosu::KbDown)
				@y += @scroll_speed
			end
			if button_down?(Gosu::KbLeft)
				@x -= @scroll_speed
			end
			if button_down?(Gosu::KbRight)
				@x += @scroll_speed
			end
		end
		
		def button_down?(id)
			@window.button_down?(id)
		end
		
		def x
			@x
		end
		
		def y
			@y
		end
		
		#@@x = 0
		#@@y = 0
		
		#def self.x
		#	@@x
		#end
		
		#def self.y
		#	@@y
		#end
		
		#def self.set_window(new_window)
		#	@@window = new_window
		#end
		
		#def self.button_down?(id)
		#	@@window.button_down?(id)
		#end
	end
end