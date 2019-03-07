module Opening
  class Director
    def initialize
      # fail
      @bg_img = Image.load('images/opening.jpg')
      @font1 = Font.new(50)
      @font2 = Font.new(100)
      @space = CP::Space.new
    end

    def play
      Window.draw(0, 0, @bg_img)
      Window.draw_font(60, 30, 'プログラミングの森', @font2, color: C_GREEN)
      Window.draw_font(200, 550, 'Push Space key to start', @font1, color: C_YELLOW)
      @space.step(1 / 60.0)
      # @circle.draw
      # @walls.each(&:draw)
      scene_transition
    end

    private

    def scene_transition
      Scene.move_to(:game) if Input.key_push?(K_SPACE)
    end
  end
end
