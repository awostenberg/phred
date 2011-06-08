require 'rubygems'
require 'gosu'
require 'bug'
require 'tile'

class GameWindow < Gosu::Window
	def self.open
		self.new.show
	end
	
	def initialize
		super(900, 900, false)													#initialize some... stuff
		self.caption = "SongBugs"
		@cursor = Cursor.new(self)
		@bugs = Array.new
		@tiles = Array.new
		@pallette = Pallette.new(self)
		@bkg_color = Gosu::Color.rgb(255, 255, 255)
		@slots = 15																#set the number of "slots" in the pallette
		@playing = false
		@interval = 10
		
		clear_all																#add the pallette bug; shorter than writing out only the needed code
		
	end
	
	def update
		if button_down?(Gosu::Button::KbC)										#delete all bugs and tiles if "C" is pressed
			clear_all
		end
		
		if (button_down?(Gosu::Button::KbSpace)) and @interval > 20
			if @playing
				@playing = false
			else
				@playing = true
			end
			@interval = 0
		end
		
		@interval = @interval + 1
		
		if @playing == true
			@bkg_color = Gosu::Color.rgb(255, 255, 255)
		else
			@bkg_color = Gosu::Color.rgb(220, 220, 220)
		end
		
		[@cursor, @pallette, @bugs, @tiles].flatten.each {|each| each.update}	#update the cursor, pallette, bugs, and tiles
	end
	
	def draw
		[@cursor, @pallette, @bugs, @tiles].flatten.each {|each| each.draw}		#draw the cursor, pallette, bugs, and tiles
		
		draw_quad(0, 0, @bkg_color,  self.width, 0, @bkg_color,  0, self.height, @bkg_color,  self.width, self.height, @bkg_color, -1)
	end
	
	def bugs
		@bugs
	end
	
	def tiles
		@tiles
	end
	
	def l_mouse_down?															#is the left mouse button down?
		button_down?(Gosu::Button::MsLeft)
	end
	
	def r_mouse_down?															#is the right mouse button down?
		button_down?(Gosu::Button::MsRight)
	end
	
	def add_bug(bug)															#add the given bug to the bugs list
		@bugs << bug
	end
	
	def add_tile(tile)
		@tiles << tile
	end
	
	def add_tiles(ary)															#add an array of tiles
		@tiles << ary
		@tiles.flatten
	end
	
	def slots
		@slots
	end
	
	def clear_all
		@bugs.clear																#clear all bugs
		@tiles.clear															#clear all tiles
		add_bug(Bug.new(self, true, @pallette))									#add a new pallette bug
		
		add_tiles(	[Tile.new(self, :A4, true, @pallette),
					Tile.new(self, :As4, true, @pallette),
					Tile.new(self, :B4, true, @pallette),
					Tile.new(self, :C4, true, @pallette),
					Tile.new(self, :Cs4, true, @pallette),
					Tile.new(self, :D4, true, @pallette),
					Tile.new(self, :Ds4, true, @pallette),
					Tile.new(self, :E4, true, @pallette),
					Tile.new(self, :F4, true, @pallette),
					Tile.new(self, :Fs4, true, @pallette),
					Tile.new(self, :G4, true, @pallette),
					Tile.new(self, :Gs4, true, @pallette),
					Tile.new(self, :rest, true, @pallette)])
	end
	
	def slot_x(slot_num)
		@pallette.x + (((width / slots) * slot_num) + 10)
	end
	
	def slot_y
		@pallette.y + ((@pallette.height / 2) - (20 / 2))
	end
	
	def pallette
		@pallette
	end
	
	def playing?
		@playing
	end
end

class Cursor
	def initialize(window)
		@window = window														#initialize me
		@image = Gosu::Image.new(@window, "images/cursor.png", false)
		@x = 0
		@y = 0
		@dragged = nil
	end
	
	def update
		@x = mouse_x
		@y = mouse_y
		
		#if not playing?																							#only if the song is not playing
		[tiles, bugs].flatten.reverse.each {|obj| 	if ((touching(obj) and @dragged == nil) and l_mouse_down?)#test if I am touching obj and I am not dragging anything, AND the left mouse button is down 
														if (obj.in_pallette?)								#test if "obj" is part of the pallette
																obj.on											#turn it on
								
															if (obj.is_bug)
																$new_obj = Bug.new(@window)					#create and add a new bug
																bugs << $new_obj
															else
																$new_obj = Tile.new(@window, obj.note_name)
																tiles << $new_obj							#create and add a new tile 
															end
									
															@dragged = $new_obj								#start dragging the new object
														else
															@dragged = obj									#if on the other hand, obj is NOT part of the pallette, then just drag it		
														end
													end
														
													if ((touching(obj) and @dragged == nil) and r_mouse_down?)#test if I am touching obj and I am not dragging anything, AND the right mouse button is down
														bugs.delete(obj)									#try to delete obj as a bug
														tiles.delete(obj)									#try to delete obj as a tile
													end}
		
		bugs.reverse.each {|bug|	if touching(bug)
										if button_down?(Gosu::Button::KbUp)
											bug.direction(0)
										end
										
										if button_down?(Gosu::Button::KbDown)
											bug.direction(2)
										end
										
										if button_down?(Gosu::Button::KbRight)
											bug.direction(1)
										end
										
										if button_down?(Gosu::Button::KbLeft)
											bug.direction(3)
										end
									end}
		
		if not l_mouse_down?																				#if the mouse is up
			@dragged = nil																				#drop the currently dragged object
			[bugs, tiles].flatten.each {|obj|	if obj.in_pallette?										#tell all the bugs in the pallette to turn off
													obj.off
												end}
												
			[bugs, tiles].flatten.each {|obj|	if (not obj.in_pallette?) and (not @dragged == obj) and ((obj.y + obj.height) > pallette.y)		#if obj is not part of the pallette, obj is not being dragged, and obj is inside the pallette
													bugs.delete(obj)									#try to delete obj as a bug
													tiles.delete(obj)									#try to delete obj as a tile
												end}
		end
		
		if not (@dragged == nil)
			@dragged.x(round_from_to(mouse_x - 10, 20))			#snap-to grid code! :D
			@dragged.y(round_from_to(mouse_y - 10, 20))
		end
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
	
	def bugs
		@window.bugs											#return all the bugs
	end
	
	def tiles
		@window.tiles											#return all the tiles
	end
	
	def width
		@image.width
	end
	
	def height
		@image.height
	end
	
	def touching(object)										#returns if I am touching the given object (HAS TO HAVE AN X AND Y METHOD)
		(((mouse_x > object.x) and (mouse_x < object.x + object.width)) and ((mouse_y > object.y) and (mouse_y < object.y + object.width)))
	end
	
	def round_from_to(num, round)								#round "num" to "round"
		((num / round).round) * round
	end
	
	def l_mouse_down?
		@window.l_mouse_down?
	end
	
	def r_mouse_down?
		@window.r_mouse_down?
	end
	
	def add_bug(bug)											#tell the window to add the given bug to the bugs list
		@window.add_bug(bug)
	end
	
	def pallette
		@window.pallette
	end
	
	def playing?
		@window.playing?
	end
	
	def button_down?(id)
		@window.button_down?(id)
	end
end

class Pallette
	def initialize(window)										#initialize meh
		@window = window
		
		@image = Gosu::Image.new(@window, "images/pallette.png", false)
		@y = @window.height - @image.height
		@x = 0
	end
	
	def update
	end
	
	def draw
		@image.draw(0, @y, 0)
	end
	
	def x
		@x
	end
	
	def y
		@y
	end
	
	def width
		@image.width
	end
	
	def height
		@image.height
	end
	
	def bugs
		@window.bugs
	end
	
	def tiles
		@window.tiles
	end
end

GameWindow.open													#start the game!