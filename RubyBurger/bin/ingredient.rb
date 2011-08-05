require 'rubygems'
require 'gosu'
                        # Generic ingredient class

require 'burger_ingredient.rb'

module RubyBurger
  class FallingIngredient
    FALL_SPEED = 5

    def initialize(window, type, x, y)
      @window = window
      @type = type
      @x = x
      @y = y
                        # A png image should exist for parameter "type"
      @image = Gosu::Image.new(@window, IMG_PATH + 'burger/' + @type + '.png', false)
    end

    def update
      step_fall
      $bb = @window.bottom_bun
      if (@x + (width / 2)).between?($bb.x, $bb.x + $bb.width) and (@y + (height / 2)).between?($bb.y, $bb.y + $bb.height)
        @y = 0
        @window.add(BurgerIngredient.new(@window, @type))
      end
    end

    def draw
                        # Draw
      @image.draw(@x, @y, 2)
    end
                        # Gradually fall down the screen
    def step_fall
      @y += FALL_SPEED
    end

    def width
      @image.width
    end

    def height
      @image.height
    end

    def x
      @x
    end

    def y
      @y
    end
  end
                        # A special ingredient: the bottom bun! It follows the mouse's x position
  class BottomBun < FallingIngredient
    def initialize(window)
      super(window, "bottom_bun", 0, 0)
    end

    def update
                        # Do not call a super method; this class maybe shouldn't be a subclass of Ingredient. I'll work that out later
      @x = mouse_x - (width / 2)
      @y = @window.height - height

                        # Don't let it go off the screen
      if @x < 0
        @x = 0
      end

      if (@x + width) > (@window.width)
        @x = @window.width - width
      end
    end

    def mouse_x
      @window.mouse_x
    end
  end
end