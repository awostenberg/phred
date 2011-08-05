require 'rubygems'
require 'gosu'
                    # This as both the basic Button class and the MenuButton class
module RubyBurger
  class Button
    def initialize(window, x, y, text, on_click_obj, on_click_method, on_click_parameters=[])
      @window = window
      @x = x
      @y = y
      @text = text
      @on_click_obj = on_click_obj
      @on_click_method = on_click_method
      @on_click_parameters = on_click_parameters
                    # Create the the text
      @image = Gosu::Image.from_text(@window, @text, "Helvetica Bold", 70)
                    # Define a shade of grey to modulate the image by when the mouse is over the button
      @over_color = Gosu::Color.rgb(200, 200, 200)
    end

    def draw
                    # If the button is touching the mouse
      if mouse_over?
        if button_down?(Gosu::MsLeft)
                    # Send @on_click_method to @on_click_obj with input(s) @on_click_parameters
          if @on_click_parameters == []
            @on_click_obj.send(@on_click_method)
          else
            @on_click_obj.send(@on_click_method, @on_click_parameters)
          end
        else
                    # Draw in the shade of grey (defined in @over_color)
          @image.draw(@x, @y, 1, 1, 1, @over_color)
        end
      else
        @image.draw(@x, @y, 1)
      end
    end

    def update
    end

    def width
      @image.width
    end

    def height
      @image.height
    end

    def mouse_over?
                    # Is the mouse touching the button?
      (mouse_x.between?(@x, @x + width)) and (mouse_y.between?(@y, @y + height))
    end

    def mouse_x
      @window.mouse_x
    end

    def mouse_y
      @window.mouse_y
    end

    def button_down?(id)
      @window.button_down?(id)
    end

    def execute

    end
  end
                    # MenuButton is basically the same as Button, except every instance auto-centers it's y position
  class MenuButton < Button
    def initialize(window, y, text, on_click_obj, on_click_method, on_click_parameters=[])
      super(window, 0, y, text, on_click_obj, on_click_method, on_click_parameters)
      center
    end

    def update
      super
                    # Center the button
      center
    end

    def center
                    # Center the button's center
      @x = (@window.width / 2) - (width / 2)
    end
  end
end