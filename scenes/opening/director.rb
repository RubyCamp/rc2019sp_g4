module Opening
  class Director
    def initialize
    end

    def play
      scene_transition
    end

    private

    def scene_transition
      Scene.move_to(:game) if Input.key_push?(K_SPACE)
    end
  end
end