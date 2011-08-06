require 'rubygems'
require 'gosu'

require 'ingredient.rb'

module RubyBurger
  class BurgerStack
    def initialize(window)
      @window = window
      @ingredients = Array.new

      @ingredients << BottomBun.new(@window)
    end

    def update
      bottom_bun.update_y(@ingredients)
      @ingredients.each {|each| each.update}
    end

    def draw
      @ingredients.each {|each| each.draw}
    end

    def add(ingredient)
      @ingredients << ingredient
    end

    def top_ingredient
      @ingredients.last
    end

    def bottom_bun
                    # Should be the first item
      @ingredients.first
    end
  end
end