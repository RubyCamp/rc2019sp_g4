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

    @haveItem=[]

  end

def move
   if @jumpable
     if @body.v.x > 0
       @current_image = @images[:right]
     elsif @body.v.x < 0
       @current_image = @images[:left]
     end
    @current_image = @images[:right] if Input.key_down?(K_RIGHT)
    @current_image = @images[:left] if Input.key_down?(K_LEFT)
  else
    @current_image = @images[:jump]
  end
    apply_force(50, 0) if Input.key_down?(K_RIGHT)
    apply_force(-50, 0) if Input.key_down?(K_LEFT)
    apply_force(0, 100) if Input.key_down?(K_DOWN)
    if Input.key_push?(K_UP) && @jumpable
      apply_force(0, -4500)

      @current_image = @images[:jump]
      @jumpable = false
    end
  end

  def draw
      @body.p.x = 850 if @body.p.x > 850
      @body.p.x = 0 if @body.p.x < 0
      @body.p.y = 52 if @body.p.y < 0
      Window.draw(@body.p.x - @r, @body.p.y - @r, @current_image )
  end

  def haveItem
    @haveItem
  end

  def get_item(item)
    @haveItem << item
  end

  def game_over
    Scene.move_to(:gameover)
  end

  def game_clear
    Scene.move_to(:gameclear)
  end
end
