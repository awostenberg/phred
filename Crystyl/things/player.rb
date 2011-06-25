require 'rubygems'
require 'gosu'
require 'things/bullet'
require 'things/progress_bar'

module CrystylGame
	Player_speed = 2.5
	class Player
		def initialize(window, type)
			@window = window
			@type = type
			@animation = Gosu::Image.load_tiles(@window, "media/images/player.png", 20, 11, false)
			@hits = [	Gosu::Sample.new(@window, "media/sounds/hit1.ogg"),
						Gosu::Sample.new(@window, "media/sounds/hit2.ogg"),
						Gosu::Sample.new(@window, "media/sounds/hit3.ogg"),
						Gosu::Sample.new(@window, "media/sounds/hit4.ogg")]
			@shoots = [	Gosu::Sample.new(@window, "media/sounds/shoot1.ogg"),
						Gosu::Sample.new(@window, "media/sounds/shoot2.ogg"),
						Gosu::Sample.new(@window, "media/sounds/shoot3.ogg"),
						Gosu::Sample.new(@window, "media/sounds/shoot4.ogg")]
			@deaths = [	Gosu::Sample.new(@window, "media/sounds/death1.ogg"),
						Gosu::Sample.new(@window, "media/sounds/death2.ogg"),
						Gosu::Sample.new(@window, "media/sounds/death3.ogg"),
						Gosu::Sample.new(@window, "media/sounds/death4.ogg")]
			
			@frame = 0
			@size = 2
			@draw_offset = 0
			@draw_offset_change = 0.3
			@weapon_interval = 10
			@frame = @animation.at(0)
			@health_bar = Progress_Bar.new(@window, self, :health)
			
			respawn
			
			if @type == 1
				@color = Gosu::Color.rgb(255, 0, 0)
				
				@nk = Gosu::KbW
				@sk = Gosu::KbS
				@ek = Gosu::KbD
				@wk = Gosu::KbA
				@firstk = Gosu::KbLeftShift
			else
				if @type == 2
				@color = Gosu::Color.rgb(0, 0, 255)
				
				@nk = Gosu::KbUp
				@sk = Gosu::KbDown
				@ek = Gosu::KbRight
				@wk = Gosu::KbLeft
				@firstk = Gosu::KbRightAlt
				else
					puts("Invalid player type: " + @type.to_s)
					@window.quit
				end
			end
		end
		
		def update
			
			move
			
			@frame = @animation.at(0)
			
			if button_down?(@firstk)
				if @weapon_interval >= 10
					$offset = Player_speed
					
					bullets << Weak_Bullet.new(@window, @x + width + $offset, @y + (height / 2), 0)
					bullets << Weak_Bullet.new(@window, @x + (width / 2), @y + height + $offset, 90)
					bullets << Weak_Bullet.new(@window, @x - $offset, @y + (height / 2), 180)
					bullets << Weak_Bullet.new(@window, @x + (width / 2), @y - $offset, 270)
					
					play_shoot_sound
					
					@weapon_interval = 0
				end
			end
			
			bullets.each {|bullet|	if ((bullet.x > @window.width) or (bullet.x < (0 - bullet.width))) or ((bullet.y > @window.height) or (bullet.y < (0 - bullet.height)))
										bullets.delete bullet
									end}
			
			bullets.each {|bullet|	if (bullet.x < (x + width)) and (bullet.x > x) and (bullet.y < (y + height)) and (bullet.y > y)
										@frame = @animation.at(1)
										bullets.delete bullet
										@health -= bullet.damage
										if not @health <= 0
											$rand = (Gosu::random(0, @hits.size - 1)).round
											$sample = @hits.at($rand)
											$sample.play
										else
											play_death_sound
											respawn
										end
									end}
			
			@health_bar.update
			
			@weapon_interval += 1
			
			@draw_offset = interval
		end
		
		def draw
			@frame.draw(@x, @y + @draw_offset, 2, @size, @size, @color)
			@health_bar.draw
		end
		
		def respawn
			if @type == 1
				@x = 0
				@y = 0
			end
			
			if @type == 2
				@x = @window.width - ((@animation.at(0).width) * @size)
				@y = 0
			end
			@health = 100
			@energy = 100
		end
		
		def interval
			((Math.sin(milliseconds / 24)))
		end
		
		def milliseconds
			Gosu::milliseconds
		end
		
		def button_down?(id)
			@window.button_down?(id)
		end
		
		def speed
			Player_speed
		end
		
		def x
			@x
		end
		
		def y
			@y
		end
		
		def height
			(@animation.at(1)).height * @size
		end
		
		def width
			(@animation.at(1)).width * @size
		end
		
		def move
			if (button_down?(@nk)) and not (@y <= 0)
				@y -= speed
			end
			if (button_down?(@sk)) and not ((@y + height) >= @window.height)
				@y += speed
			end
			if (button_down?(@wk)) and not (@x <= 0)
				@x -= speed
			end
			if (button_down?(@ek)) and not ((@x + width) >= @window.width)
				@x += speed
			end
		end
		
		def bullets
			@window.bullets
		end
		
		def delete
			@window.delete(self)
		end
		
		def health
			@health
		end
		
		def play_shoot_sound
			(@shoots.at(Gosu::random(0, (@shoots.size).round))).play
		end
		
		def play_death_sound
			(@deaths.at(Gosu::random(0, (@deaths.size).round))).play
		end
		
		def type
			@type
		end
	end
end