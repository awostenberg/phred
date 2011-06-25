require 'rubygems'
require 'gosu'

module CrystylGame
	class Crystyl
		def initialize(window)
			@window = window
			@animation = Gosu::Image.load_tiles(@window, "media/images/crystyl.png", 40, 40, false)
			@interval = @frame = 0
			@color = Gosu::Color.rgb(200, 0, 200)
			@size = 1
		end
		
		def update
			if (@frame + 1) == @animation.size
				@interval = 0
			end
			
			@interval += 0.05
			@frame = @interval.round
		end
		
		def draw
			@image = @animation.at(@frame)
			@image.draw(100, 100, 2, @size, @size, @color)
		end
	end
end