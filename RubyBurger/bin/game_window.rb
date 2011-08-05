require 'rubygems'
require 'gosu'

                        # Change to the appropriate directory
Dir.chdir(File.dirname(__FILE__))

                    # Now require can be used more easily
require 'main_menu.rb'
require 'ingredient.rb'
require 'burger_ingredient.rb'
require 'burger.rb'


module RubyBurger
                    # Specify the images folder
  IMG_PATH = 'media/images/'

  class GameWindow < Gosu::Window
    def self.open   # Create and show a new instance of GameWindow
      self.new.show
    end

    # -----

    def initialize
      super(1000, 1000, false)
      self.caption = 'RubyBurger by J. Wostenberg 2011'
                        # Set the background color
      @bkg_color = Gosu::Color.rgb(0, 128, 255)
      @bkg_color1 = Gosu::Color.rgb(0, 255, 255)
      @bkg_color2 = Gosu::Color.rgb(0, 128, 255)

                    # All objects that want their update and draw methods to be called should go in here
      @objects = Array.new
                    # The main menu
      @objects << MainMenu.new(self)
    end

    def update
      @objects.each {|obj| obj.update}
    end

    def draw
      draw_background
      @objects.each {|obj| obj.draw}
    end

    def draw_background
                         # Draw the background
      draw_quad(0, 0, @bkg_color1, width, 0, @bkg_color1, 0, height, @bkg_color2, width, height, @bkg_color2)
    end

    def needs_cursor?    # Use the system mouse
      true
    end

    def play
                         # Delete the main menu
      delete_inst(MainMenu)
                         # Start the game
      #@objects << BottomBun.new(self)
      @objects << FallingIngredient.new(self, 'top_bun', 500, 0)

      @objects << BurgerStack.new(self)
    end

    def delete_inst(objclass)     # If anything in @objects is an instance of objclass, remove it
      @objects.each {|obj| @objects.delete(obj) if (obj.class == objclass)}
    end

    def bottom_bun
      burger_stack.top_ingredient
    end

    def add(ingredient)
      burger_stack.add(ingredient)
    end

    def burger_stack
      @objects.each {|obj| $ans = obj if (obj.class == BurgerStack)}
      $ans
    end
  end
end