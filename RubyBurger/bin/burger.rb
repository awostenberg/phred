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
  end
end