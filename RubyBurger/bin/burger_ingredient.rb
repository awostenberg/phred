require 'gosu'
require 'rubygems'

module RubyBurger
  class BurgerIngredient
    def initialize(window, type)
      @window = window
      @type = type

                        # A png image should exist for parameter "type"
      @image = Gosu::Image.new(@window, IMG_PATH + 'burger/' + @type + '.png', false)

      @next_below = @window.topIngredient
                        # Set the position once for @history
      @x = (@next_below.history).last
      @y = @next_below.y - height

      @history = Array.new
      5.times {|i| @history << @x}
    end

    def update
      @history.insert(0, @x)
      @history.delete_at(-1)

      $x = (@next_below.history).last
      #if $x < -5
      #  @x -= -5
      #else
      #  if $x > 5
      #    @x += 5
      #  else
      #    @x = $x
      #  end
      #end

      @x = @next_below.x
      @y = @next_below.y - height
    end

    def draw
      @image.draw(@x, @y, 2)
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

    def history
      @history
    end
  end
end