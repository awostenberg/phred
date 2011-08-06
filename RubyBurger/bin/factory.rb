require 'rubygems'
require 'gosu'

                    # Instances of this class create ingredients the fall from the top of the screen at a regular interval

require 'ingredient.rb'

module RubyBurger
  class Factory
    def listOfValidIngredientTypes
      ["top_bun", "patty", "cheese", "tomato", "bacon", "onion"]
    end

    def initialize(window)
      @window = window
      @ingredients = Array.new
      @ingredient_types = listOfValidIngredientTypes()
      @interval = 0
    end

    def spawnIngredientOnTime
      if (@interval == 50)
        create_ingredient
        @interval = 0
      end
    end

    def update
      spawnIngredientOnTime()
                    # Change the time
      @interval += 1
                    # Update the ingredients
      @ingredients.each {|each| each.update}
    end

    def draw
      @ingredients.each {|each| each.draw}
    end

    def create_ingredient
                    # Spawn a random ingredient at a random position at the top of the screen and let it drop!
      @ingredients << FallingIngredient.new(@window, @ingredient_types.at(Gosu::random(0, @ingredient_types.length)), Gosu::random(0, @window.width - 50), -20)
    end

    def delete(ingredient)
                    # Delete the given ingredient
      @ingredients.delete(ingredient)
    end
  end
end