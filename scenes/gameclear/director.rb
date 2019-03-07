module Gameclear
  class Director
    def initialize
      @bg_img = Image.load('images/gameclear_bg.png')
    end

    def play
      Window.draw(0, 0, @bg_img)
    end
  end
end
