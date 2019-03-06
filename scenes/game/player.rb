# 操作対象となるプレイヤーキャラクタ
class Player < CPCircle
  # 衝突判定区分を設定
  COLLISION_TYPE = 1

  #def initialize
  #  super
  #  @hp = 100

  #end

  # 1フレーム分の移動ロジック
  # キーボードの左右とスペースキーを受け付け、それぞれの方向に加速度を与える
  # 左右キーは押しっ放しに対応する。

  def initialize(x,y,r,mass,e = 0, u = 0)

    @images= {
      right: Image.load("images/player_run1.png"),
      left: Image.load("images/player_run2.png"),
      jump: Image.load("images/player_jump.png")
    }

    @current_image = @images[:right]
    super(x,y,r,mass,@current_image,e,u)
  end3

  def move
    @current_image = @images[:right] if Input.key_push?(K_RIGHT)
    @current_image = @images[:left] if Input.key_push?(K_LEFT)
    @current_image = @images[:jump] if Input.key_push?(K_DOWN)

    apply_force(30, 0) if Input.key_down?(K_RIGHT)
    apply_force(-30, 0) if Input.key_down?(K_LEFT)
    apply_force(0, 100) if Input.key_down?(K_DOWN)
    if Input.key_push?(K_UP)
      apply_force(0, -750)
      @current_image = @images[:jump]
    end
  end

  def draw
    Window.draw(@body.p.x - @r, @body.p.y - @r, @current_image )
  end

end
end
