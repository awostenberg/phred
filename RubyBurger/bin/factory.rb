require 'rubygems'
require 'gosu'

                    # Instances of this class create ingredients the fall from the top of the screen at a regular interval

require 'ingredient.rb'

module RubyBurger
  class Factory
    def initialze(window)
      @window = window
      @ingredients = Array.new
    end

    def update
    end

    def draw
    end
  end
end