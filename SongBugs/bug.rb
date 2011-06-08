require 'rubygems'
require 'gosu'

class Bug
	def initialize(window, in_pallette = false, pallette = nil, direction = 0)
		@window = window
		@in_pallette = in_pallette
		@pallette = pallette
		@x = 0
		@y = 0
		@direction = direction
		@off = Gosu::Image.new(@window, "images/bug_off.png", false)
		@on = Gosu::Image.new(@window, "images/bug_on.png", false)
		@state = :off
		@interval = 0
	end
	
	def update
		if @in_pallette
			@x = @window.slot_x(0)
			@y = @window.slot_y
		end
		
		if not @in_pallette
			if playing? and (@interval == 50)
				tick
				@interval = 0
			end
		end
		
		if playing?
			@interval = @interval + 1
		else
			off
			@interval = 50
		end
	end
	
	def draw
		if (@state == :on)
			@on.draw_rot(@x + 10, @y + 10, 2, @direction * 90, 0.5)
		else
			@off.draw_rot(@x + 10, @y + 10, 2, @direction * 90, 0.5)
		end
	end
	
	def width
		if (@state == :on)
			@on.width
		else
			@off.width
		end
	end
	
	def height
		if (@state == :on)
			@on.height
		else
			@off.height
		end
	end
	
	def on
		@state = :on
	end
	
	def off
		@state = :off
	end
	
	def x
		@x
	end
	
	def y
		@y
	end
	
	def x(new_x = @x)
		@x = new_x
	end

	def y(new_y = @y)
		@y = new_y
	end
	
	def being_dragged(boolean)
		@being_dragged = boolean
	end
	
	def in_pallette?
		@in_pallette
	end
	
	def slots
		@window.slots
	end
	
	def is_bug
		true
	end
	
	def tiles
		@window.tiles
	end
	
	def playing?
		@window.playing?
	end
	
	def direction(new_dir)
		@direction = new_dir
	end
	
	def tick
		if not @in_pallette

			if @direction == 0
				up
			else
				if @direction == 2
					down
				else
					if @direction == 1
						right
					else
						if @direction == 3
							left
						else
							off
						end
					end
				end
			end

		end
	end
	
	def tile_above
		tiles.flatten.each {|tile|	if (not tile.in_pallette?) and (tile.x == x) and (tile.y == (@y - height))
										$t = tile
									end}
		if not $t == nil
			if ($t.x == x) and ($t.y == (@y - height))
				$t
			end
		end
	end
	
	def tile_below
		tiles.flatten.each {|tile|	if (not tile.in_pallette?) and (tile.x == x) and (tile.y == (@y + height))
										$t = tile
									end}
		if not $t == nil
			if ($t.x == x) and ($t.y == (@y + height))
				$t
			end
		end
	end
	
	def tile_right
		tiles.flatten.each {|tile|	if (not tile.in_pallette?) and (tile.x == (@x + width)) and (tile.y == y)
										$t = tile
									end}
		if not $t == nil
			if ($t.x == (@x + width)) and ($t.y == y)
				$t
			end
		end
	end
	
	def tile_left
		tiles.flatten.each {|tile|	if (not tile.in_pallette?) and (tile.x == (@x - width)) and (tile.y == y)
										$t = tile
									end}
		if not $t == nil
			if ($t.x == (@x - width)) and ($t.y == y)
				$t
			end
		end
	end
	
	def up
		if not tile_above == nil
			tile_above.play
			@y = @y - height
			on
			@direction = 0
		else
			if not tile_right == nil
				tile_right.play
				@x = @x + width
				on
				@direction = 1
			else
				if not tile_left == nil
					tile_left.play
					@x = @x - width
					on
					@direction = 3
				else
					off
				end
			end
		end
	end
	
	def down
		if not tile_below == nil
			tile_below.play
			@y = @y + height
			on
			@direction = 2
		else
			if not tile_right == nil
				tile_right.play
				@x = @x + width
				on
				@direction = 1
			else
				if not tile_left == nil
					tile_left.play
					@x = @x - width
					on
					@direction = 3
				else
					off
				end
			end
		end
	end
	
	def right
		if not tile_right == nil
			tile_right.play
			@x = @x + width
			on
			@direction = 1
		else
			if not tile_above == nil
				tile_above.play
				@y = @y - height
				on
				@direction = 0
			else
				if not tile_below == nil
					tile_below.play
					@y = @y + height
					on
					@direction = 2
				else
					off
				end
			end
		end
	end
	
	def left
	if not tile_left == nil
			tile_left.play
			@x = @x - width
			on
			@direction = 3
		else
			if not tile_above == nil
				tile_above.play
				@y = @y - height
				on
				@direction = 0
			else
				if not tile_below == nil
					tile_below.play
					@y = @y + height
					on
					@direction = 2
				else
					off
				end
			end
		end
	end
end