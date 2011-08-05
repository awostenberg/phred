require 'gosu'
require 'rubygems'

module RubyBurger
  class BurgerIngredient
    def initialize(window, type)
      @window = window
      @type = type

                        # A png image should exist for parameter "type"
      @image = Gosu::Image.new(@window, IMG_PATH + 'burger/' + @type + '.png', false)

      @next_below = @window.bottom_bun
    end

    def update
      @x = @next_below.x
      @y = @next_below.y - height
    end

    def draw
      @image.draw(@x, @y, 2)
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

    def width
      @image.width
    end

    def height
      @image.height
    end
  end
end