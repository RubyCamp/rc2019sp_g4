class Player < CPCircle
  COLLISION_TYPE = 1
  attr_accessor :jumpable

  def initialize(x,y,r,mass,e, u)

    @images= {
      right: Image.load("images/player_run1.png"),
      left: Image.load("images/player_run2.png"),
      jump: Image.load("images/player_jump.png")
    }

    @current_image = @images[:right]
    super(x,y,r,mass,@current_image,e,u)

    @jumpable = true

  end

  def move
    @current_image = @images[:right] if Input.key_push?(K_RIGHT)
    @current_image = @images[:left] if Input.key_push?(K_LEFT)
    @current_image = @images[:jump] if Input.key_push?(K_DOWN)

    apply_force(50, 0) if Input.key_down?(K_RIGHT)
    apply_force(-50, 0) if Input.key_down?(K_LEFT)
    apply_force(0, 100) if Input.key_down?(K_DOWN)
    if Input.key_push?(K_UP) && @jumpable
      apply_force(0, -5000)

      @current_image = @images[:jump]
      @jumpable = false
    end
  end

  def draw
    Window.draw(@body.p.x - @r, @body.p.y - @r, @current_image )
  end

end
