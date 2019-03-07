module Opening
  class Director
    def initialize
      # fail
      @bg_img = Image.load('images/opening.jpg')
      @font1 = Font.new(50)
      @font2 = Font.new(100)
      @space = CP::Space.new
      # @space.gravity = CP::Vec2.new(0, 150)
      # @circle = CPCircle.new(100, 100, 20, 1, C_BLUE, 1.0, 1.0)
      # @circle.apply_force(200, 0)
      # @walls = CPBase.walls
      # @space.add(@circle)
      # @walls.each do |wall|
      #   @space.add(wall)
      # end
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
