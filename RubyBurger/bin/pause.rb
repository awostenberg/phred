require 'rubygems'
require 'gosu'

module RubyBurger
  class Pause
    def initialize(window)
      @window = window
      @image = Gosu::Image.new(@window, IMG_PATH + "pause.png", false)
    end

    def update
    end

    def draw
      @image.draw((@window.width / 2) - (width / 2), (@window.height / 3) - (height / 2), 3)
    end

    def width
      @image.width
    end

    def height
      @image.height
    end
  end
end