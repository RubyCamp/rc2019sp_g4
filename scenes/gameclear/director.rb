module Gameclear
  class Director
    def initialize
      @bg_img = Image.load('images/gameclear_bg.png')
      @font = Font.new(30)
    end

    def play
      Window.draw(0, 0, @bg_img)
      score = Game::Director::get_score
      Window.draw_font(740, 10, "SCORE: #{score}", @font, color: C_WHITE)
    end
  end
end
