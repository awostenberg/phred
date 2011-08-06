require 'rubygems'
require 'gosu'
                        # Generic ingredient class

require 'burger_ingredient.rb'

module RubyBurger
  class FallingIngredient

    def initialize(window, type, x, y)
      @window = window
      @type = type
      @x = x
      @y = y
                        # A png image should exist for parameter "type"
      @image = Gosu::Image.new(@window, IMG_PATH + 'burger/' + @type + '.png', false)
    end

    def update
                        # Test if this item should be stacked on top of the burger
      $topIngredient = @window.topIngredient
                        # Is it positioned properly?
      if (@x + (width / 2)).between?($topIngredient.x, $topIngredient.x + $topIngredient.width) and (@y.between?($topIngredient.y - 20, $topIngredient.y))
                        # Create a new instance of Burger_Ingredient of this ingredient's type
        $newbi = BurgerIngredient.new(@window, @type)
        $newbi.update
        @window.add($newbi)
        delete
      end

      stepFall
    end

    def draw
      @image.draw(@x, @y, 2)
    end

    def fallSpeed
      5
    end

    def stepFall
      @y += fallSpeed()
    end

    def delete
      @window.deleteFallingIngredient(self)
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

  class BottomBun
    def initialize(window)
      @window = window
      @image = Gosu::Image.new(@window, IMG_PATH + "burger/bottom_bun.png", false)
                        # Sets how many ingredients high the burger can be stacked before it starts scrolling down
      @stack_limit = 20
                        # Set the bun's position so it can be stored in @history
      update_x
      update_y([])
                        # This is used for the "swaying" of the burger
      @history = Array.new
      2.times {|i| @history << @x}

      @vel = 0
    end

    def draw
                        # Draw
      @image.draw(@x, @y, 2)
    end

    def update
                        # Move
      if button_down?(Gosu::KbLeft)
        @vel -= 0.25
      else
        if button_down?(Gosu::KbRight)
          @vel += 0.25
        else
          @vel = @vel / 1.1
        end
      end
      #@vel.round
      @x += @vel

                        # Don't let it go off the screen
      if @x < 0
        @x = 0
        @vel = 0
      end

      if (@x + width) > (@window.width)
        @x = @window.width - width
        @vel = 0
      end
                        # Add my current x position to @history
      @history.insert(0, @x)
      @history.delete_at(-1)
    end

    def mouse_x
      @window.mouse_x
    end

    def update_y(stack)
                        # Figure out the correct y position. After all, everything else on the burger relies on it
      @y = @window.height - height
      $l = (stack.length - 1) - @stack_limit
      if $l < 0
        $l = 0
      end
      @y += ($l * height)
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

    def update_x
      @x = mouse_x - (width / 2)
    end

    def history
      @history
    end

    def button_down?(id)
      @window.button_down?(id)
    end
  end
end