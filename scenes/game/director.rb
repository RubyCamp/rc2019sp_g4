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
      @space.gravity = CP::Vec2.new(0, 1000) #重力500として作成
      
      #オブジェクトの配列
      @objects = []
      # オブジェクトがウィンドウの範囲を出ないよう、範囲のすぐ外側の4方向に固定の壁を設置
      CPBase.generate_walls(@space)
      # プレイヤーオブジェクト（円オブジェクト）作成
      #player = Player.new(21, 300, 20, 1, C_BLUE)

      # エネミーオブジェクトの生成
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

      #Ruby生成
      3.times do
        r=Ruby.new(rand(800),rand(400),30,30)
        @space.add(r)
        @objects << r
      end

      #itembox生成 staticが生成できない
      itembox=ItemBox.new(450,450,500,500)
      @space.add(itembox)
      @objects<<itembox

      #PlayerがRubyを取得
      @deleting_objs=[]
      @space.add_collision_handler(Player::COLLISION_TYPE, Ruby::COLLISION_TYPE) do |a, b, arb|
        @deleting_objs << b.parent_obj
        sound.play
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
        @deleting_objs << b.parent_obj
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

      player = Player.new(400, 500, 45, 10, 0, 1)
      @space.add(player)
      @objects << player
      

      def play
        #BGMを再生する
        if @i==0 then
          @bgm.play
          @i=1
        end

        Window.draw(0, 0, @bg_img)

        #削除予定のオブジェクトを削除
        @deleting_objs.each do |obj|
          @space.remove(obj)
          @objects.delete(obj)
        end

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

        @space.step(1 / 60.0)
        scene_transition if @min < 0 end
      end

      def scene_transition
        Scene.move_to(:ending)
      end
   end
end
