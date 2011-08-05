require 'rubygems'
require 'gosu'

require 'button.rb'

module RubyBurger
  class MainMenu
    def initialize(window)
      @window = window
                    # This is the title image
      @title = Gosu::Image.new(window, IMG_PATH + 'RubyBurger.png')
                    # Button array. Add new buttons here
      @buttons = Array.new
                    # Add the buttons
      #@buttons << MenuButton.new(@window, 326, :play, @window, :play)
      @buttons << MenuButton.new(@window, 336, "play", @window, :play)
    end

    def update
                    # Update each button
      @buttons.each {|button| button.update}
    end

    def draw
                    # Draw the title image and buttons
      @title.draw((@window.width / 2) - (@title.width / 2), 10, 1)
      @buttons.each {|button| button.draw}
    end
  end
end