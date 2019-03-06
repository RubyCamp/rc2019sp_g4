module Game
  class Director
    def initialize
      @space = CP::Space.new
      @space.gravity = CP::Vec2.new(0, 500) #重力500として作成

      @objects = []
      # オブジェクトがウィンドウの範囲を出ないよう、範囲のすぐ外側の4方向に固定の壁を設置
      CPBase.generate_walls(@space)
      # プレイヤーオブジェクト（円オブジェクト）作成
      #player = Player.new(21, 300, 20, 1, C_BLUE)

      # エネミーオブジェクトの生成
      # initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
      dlang = Dlang.new(0, 0, 50, 50, 'images/dlang.png')
      elephpant = Elephpant.new(50, 50, 20, 30, 'images/elephpant.png')
      gopher = Gopher.new(100, 100, 10, 30, 'images/gopher.png')
      python = Python.new(150, 150, 90, 70, 'images/python.png')

      enemies = []
      enemies << dlang
      enemies << elephpant
      enemies << gopher
      enemies << python

      p enemies
      enemies.each do |enemy|
        @space.add(enemy)
      end

      #@opbjects = [enemies]
      enemies.map do |enemy|
        @objects << enemy
      end

      p @objects

      # プレイヤーオブジェクトを物理演算空間に登録
      #@space.add(player)
      # ゲーム世界に登場する全てのオブジェクトを格納する配列を定義
      #@objects = [player]

      # ゲーム世界に障害物となる静的BOXを追加
      block = CPStaticBox.new(200, 350, 600, 400)
      @space.add(block)

      @objects << block

      # 敵キャラクタ（四角形）を10個ほど生成して、物理演算空間に登録＆@objecctsに格納
      #4.times do
        #e = Enemy.new(100 + rand(500), 100 + rand(300), 30, 30,'images/block_base.png', 10, C_RED)
        #@space.add(e)
        #@objects << e
      #end

      # プレイヤーオブジェクトと敵オブジェクトが衝突した際の振る舞いを定義する
      # 以下の定義にて、プレイヤーと敵が衝突した際に、自動的にブロックの内容が実行される。
      # ブロック引数の意味はそれぞれ以下の通り。
      # a: 衝突元（この場合はプレイヤー）のshapeオブジェクト
      # b: 衝突先（この場合は敵）のshapeオブジェクト
      # arb: 衝突情報を保持するArbiterオブジェクト
      # ※ 本プログラムでは、各shapeにattr_accessorでparent_objを定義してある。
      # 　 例えば、playerオブジェクトを得る場合は a.parent_obj のようにすると取得できる
      #@space.add_collision_handler(Player::COLLISION_TYPE, Enemy::COLLISION_TYPE) do |a, b, arb|
        # 衝突個所（arb.points配列）から、先頭の1つを取得（複数個所ぶつかるケースもあり得るため配列になっている）
        #pos = arb.points.first.point
        # 衝突個所の座標に絵を表示（1フレームで消える点に留意）
       # Window.draw(pos.x, pos.y, star_img)
      #end

      @space.gravity = CP::Vec2.new(0, 500)

      CPBase.generate_walls(@space)

      # player = Player.new(400, 500, 45, 1, C_BLUE)
    #   @space.add(player)
    #   @objects = [player]
    # end

    def play
      @objects.each do |obj|
        obj.move  # 1フレーム分の移動処理
        obj.draw  # 1フレーム分の描画処理
      end
      @space.step(1 / 60.0)
    end
  end
end
end
