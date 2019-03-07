module Gameover
  class Director
    def initialize
      @bg_img = Image.load('images/gameover.jpg')
      @font = Font.new(30)
    end

    def play
      score = Game::Director::get_score
      Window.draw(0, 0, @bg_img)
      Window.draw_font(740, 10, "SCORE: #{score}", @font, color: C_WHITE)
    end
  end
end