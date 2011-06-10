require 'rubygems'
require 'gosu'


class Note	#I am just a storage place for a note name, and I know what color represents me, and the pallette position for any tile that uses my note
	def initialize(window, note_name)							#initialize me
		@window = window
		@note_name = note_name
		@sample = Gosu::Sample.new(@window, "sounds/" + @note_name.to_s + ".wav")
		@colors = Array.new
		
		$black = [:rest, Gosu::Color.rgb(0, 0, 0), 2]			#the 1st object (position 0) is the note name. the 2nd (position 1) is the note color. the 3rd (pos. 2) and final object represents the slot position for that note. this goes for all color arrays
		@colors << $black
		
		$red = [:A4, Gosu::Color.rgb(255, 0, 0), 4]
		@colors << $red
		
		$light_red = [:As4, Gosu::Color.rgb(255, 0, 127), 5]
		@colors << $light_red
		
		$orange = [:B4, Gosu::Color.rgb(255, 127, 0), 6]
		@colors << $orange
		
		$yellow = [:C4, Gosu::Color.rgb(255, 255, 0), 7]
		@colors << $yellow
		
		$yellow_green = [:Cs4, Gosu::Color.rgb(127, 255, 0), 8]
		@colors << $yellow_green
		
		$green = [:D4, Gosu::Color.rgb(0, 255, 0), 9]
		@colors << $green
		
		$blue_green = [:Ds4, Gosu::Color.rgb(0, 255, 127), 10]
		@colors << $blue_green
		
		$cyan = [:E4, Gosu::Color.rgb(0, 255, 255), 11]
		@colors << $cyan
		
		$light_blue = [:F4, Gosu::Color.rgb(0, 196, 255), 12]
		@colors << $light_blue
		
		$blue = [:Fs4, Gosu::Color.rgb(0, 0, 255), 13]
		@colors << $blue
		
		$purple = [:G4, Gosu::Color.rgb(127, 0, 255), 14]
		@colors << $purple
		
		$pink = [:Gs4, Gosu::Color.rgb(255, 127, 255), 15]
		@colors << $pink
		
	end
	
	def note_name
		@note_name
	end
	
	def name_color
		@colors.each {|color_array| 	if (color_array.at(0) == @note_name)
											$color = color_array.at(1)
										end}
		if $color == nil
			$color = Gosu::Color.rgb(0, 0, 0)
		end
		
		$color
	end
	
	def name_slot_x
		@colors.each {|color_array|		if (color_array.at(0) == @note_name)
											$slot_x = color_array.at(2)
										end}
		$slot_x
	end
	
	def play
		@sample.play
	end
end

class Tile
	def initialize(window, note_name, in_pallette = false, pallette = nil)	#initialization
		@window = window
		@in_pallette = in_pallette
		@note = Note.new(@window, note_name)
		@image = Gosu::Image.new(@window, "images/tile.png")
		@x = 20
		@y = 20
		@color = @note.name_color
		@being_dragged = false
	end
	
	def update
		@color = @note.name_color
		if @in_pallette
			@x = slot_x(@note.name_slot_x)
			@y = slot_y
		end
	end
	
	def draw
		@image.draw(@x, @y, 1, 1, 1, @color)
	end
	
	def on																	#added for compatibility; just play my note
		play
	end
	
	def off																	#added for compatibility
	end
	
	def is_bug
		false
	end
	
	def in_pallette?
		@in_pallette
	end
	
	def x(new_x = @x)
		@x = new_x
	end
	
	def y(new_y = @y)
		@y = new_y
	end
	
	def width
		@image.width
	end
	
	def height
		@image.height
	end
	
	def slot_x(slot_num)
		@window.slot_x(slot_num)
	end
	
	def slot_y
		@window.slot_y
	end
	
	def note_name
		@note.note_name
	end
	
	def being_dragged(new_being_dragged = @being_dragged)
		@being_dragged = new_being_dragged
	end
	
	def play
		@note.play
	end
end