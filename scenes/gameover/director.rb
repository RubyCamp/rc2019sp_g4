module Gameover
  class Director
    def initialize
      @bg_img = Image.load('images/gameover.jpg')
      @font = Font.new(30)
    end

    def play
      score = Game::Director::get_score
      time = Game::Director::get_time
      min = time / 60
      sec = time % 60
      Window.draw(0, 0, @bg_img)
      Window.draw_font(740, 10, "SCORE: #{score}\nTIME#{min}:#{sec}", @font, color: C_WHITE)
    end
  end
end