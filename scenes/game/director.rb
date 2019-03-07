module Game
  class Director
    def initialize
      # スコア表示
      @font = Font.new(24)
      @score = 0
      @highscore = 100

      # タイマー表示
      @limit_time = 20  # 分*60
      @start_time = Time.now

      #BGM
      sound = Sound.new("sound/ruby.wav")  # sound.wav読み込み
      @bgm = Sound.new("sound/bgm.WAV")
      @i=0


      @space = CP::Space.new
      @space.gravity = CP::Vec2.new(0, 100) #重力500として作成

      @objects = []
      # オブジェクトがウィンドウの範囲を出ないよう、範囲のすぐ外側の4方向に固定の壁を設置
      CPBase.generate_walls(@space)
      # プレイヤーオブジェクト（円オブジェクト）作成
      #player = Player.new(21, 300, 20, 1, C_BLUE)

      # エネミーオブジェクトの生成
      # initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
      dlang = Dlang.new(-100, 200, 20, 1, 'images/dlang.png')
      elephpant = Elephpant.new(400, 500, 20, 1, 'images/elephpant.png')
      gopher = Gopher.new(400, 500, 20, 1, 'images/gopher.png')
      python = Python.new(500, 500, 20, 1, 'images/python.png')


      enemies = []
      enemies << dlang
      enemies << elephpant
      enemies << gopher
      enemies << python

      enemies.each do |enemy|
        @space.add(enemy)
      end

      enemies.map do |enemy|
        @objects << enemy
      end

      # ゲーム世界に障害物となる静的BOXを追加
      @bg_img = Image.load('images/back_bg.png')
      @space = CP::Space.new
      @space.gravity = CP::Vec2.new(0, 150)



      #Ruby生成
      3.times do
        r=Ruby_.new(rand(800),rand(100),30,30)
        @space.add(r)
        @objects << r
      end

      #itembox生成 staticが生成できない
      itembox=ItemBox.new(450,450,500,500)
      @space.add(itembox)
      @objects<<itembox

      # 敵キャラクタ（四角形）を10個ほど生成して、物理演算空間に登録＆@objecctsに格納
      #4.times do
        #e = Enemy.new(100 + rand(500), 100 + rand(300), 30, 30,'images/block_base.png', 10, C_RED)
        #@space.add(e)
        #@objects << e
      #end

      #PlayerがRubyを取得
      @space.add_collision_handler(Player::COLLISION_TYPE, Ruby_::COLLISION_TYPE) do |a, b, arb|
        # DXrubyを削除
        sound.play
        # b.dispose
        # CPを削除
        @space.remove(b)
      end

      @add_objs=[]
      itemFlg=true
      #PlayerがItemBoxをタッチ
      @space.add_collision_handler(Player::COLLISION_TYPE, ItemBox::COLLISION_TYPE) do |a, b, arb|
        # 衝突個所（arb.points配列）から、先頭の1つを取得（複数個所ぶつかるケースもあり得るため配列になっている）
        pos = arb.points.first.point
        # 衝突個所の反対座標にItemを生成

        if itemFlg==true
          @add_objs << pos
          itemFlg=false
        end
        true
      end
      #PlayerがRubyを取得
      @space.add_collision_handler(Player::COLLISION_TYPE, Item::COLLISION_TYPE) do |a, b, arb|
        @deletiing_obj << b.parent_obj
      end


      @space.gravity = CP::Vec2.new(0, 1000)

      @walls = []
      @walls << CPStaticBox.new(0, 600, 900, 620)
      @walls << CPStaticBox.new(0, 620, 900, 640)
      @walls << CPStaticBox.new(0, 640, 900, 650)

      @walls << CPStaticBox.new(180, 480, 360, 500)
      @walls << CPStaticBox.new(540, 480, 720, 500)
      @walls << CPStaticBox.new(360, 200, 540, 220)

      #@space.add(@current)
      @walls.each do |wall|
        @space.add(wall)
      end

      CPBase.generate_walls(@space)
         player = Player.new(400, 500, 45, 10, 0, 1)
         @space.add(player)
         @objects << player
      end

      def play
        #BGMを再生する
        if @i==0 then
        @bgm.play
        @i=1
        end


        Window.draw(0, 0, @bg_img)

        @walls.each do |wall|
          wall.draw
        end

        
        @add_objs.each do |obj2|
          item=Item.new(430,440,30,30,1)
          @space.add(item)
          @objects << item
          @add_objs.delete(obj2)
        end

        @space.add_collision_handler(Player::COLLISION_TYPE, CPStaticBox::COLLISION_TYPE) do |a, b, arb|
          player = a.parent_obj
          #puts player.body.v.y
          if player.body.v.y >= 0
            player.jumpable = true
          end
        end


        # ゲーム空間に配置された全てのオブジェクトに対して同じ処理を実施して回る
        @objects.each do |obj|
          obj.move  # 1フレーム分の移動処理
          obj.draw  # 1フレーム分の描画処理
        end

        # スコア表示
        Window.draw_font(650,10,"★HIGHSCORE★: #{@highscore}", @font)
        Window.draw_font(650, 40, "SCORE: #{@score}",@font)

        # タイマー表示
        @now_time = Time.now
        @diff_time = @now_time - @start_time
        countdown = (@limit_time - @diff_time).to_i
        @min = countdown / 60
        @sec = countdown % 60
        Window.drawFont(10, 10, "#{@min}:#{@sec}", @font)

        #bgm
        if Input.key_push?(K_Z) then  # Zキーで再生
        end

        @space.step(1 / 60.0)
        scene_transition if @min < 0
      end

      def scene_transition
        Scene.move_to(:ending)
      end

   end
end
