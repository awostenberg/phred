module Colonies
	class Camera	#This turned out more simple than I though it would be... :D
		def initialize(window)
			@window = window
			@scroll_speed = 10
			@x = 0
			@y = 0
			@zoom = 1
			@zoom_speed = 0.0625
		end
		
		def update
					#Here comes the fun scrolling part
			if button_down?(Gosu::KbW)
				@y -= scroll_speed
			end
			if button_down?(Gosu::KbS)
				@y += scroll_speed
			end
			if button_down?(Gosu::KbA)
				@x -= scroll_speed
			end
			if button_down?(Gosu::KbD)
				@x += scroll_speed
			end
					#Center the screen and reset the zoom when space is pressed
			if button_down?(Gosu::KbSpace)
				@x = 0
				@y = 0
				@zoom = 1
			end
					#These next two conditionals control the zooming
			if button_down?(Gosu::KbE) and (not @zoom >= 4)
				@zoom += @zoom_speed
			end
			if button_down?(Gosu::KbQ) and (not @zoom <= 1)
				@zoom -= @zoom_speed
			end
			
					#Error catching for @zoom being less than 1, which should never happen
			if @zoom < 1
				puts "=== ERROR: zoom is less than 1; should never happen! ==="
			end
		end
		
		def scroll_speed
					#Figure out how fast scrolling should be
			if button_down?(Gosu::KbTab)
				@scroll_speed * 5
			else
				@scroll_speed
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
		
		def zoom
			@zoom
		end
	end
end