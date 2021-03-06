module Game
  class Director
    def initialize
      # スコア表示
      @font = Font.new(30)
      @@score = 0
      @highscore = 100

      # タイマー表示
      @limit_time = 180  # 分*60
      @start_time = Time.now

      #BGM
      sound = Sound.new("sound/ruby.wav")  # sound.wav読み込み
      @bgm = Sound.new("sound/bgm.wav")
      @i = 0

      @box_x11 = rand(0 .. 450)
      @box_x12 = @box_x11 + 100
      @box_x21 = rand(0 .. 450)
      @box_x22 = @box_x21 + 100
      @box_x31 = rand(450 .. 900)
      @box_x32 = @box_x31 + 100
      @box_x41 = rand(450 .. 900)
      @box_x42 = @box_x41 + 100

      @box_y11 = 480
      @box_y12 = 500
      @box_y21 = 350
      @box_y22 = 370
      @box_y31 = 100
      @box_y32 = 120
      @box_y41 = 50
      @box_y42 = 70

      @add_objs = []
      @deleting_objs = []
      @add_items = []
      @walls = []
      @deleting_items = []
      @objects = []

      @item_Flg = true
      ruby_Flg = true

      enemies_Defeated_Num = 0
      @interval = 0

      @space = CP::Space.new
      @space.gravity = CP::Vec2.new(0, 1000)

      # オブジェクトがウィンドウの範囲を出ないよう、範囲のすぐ外側の4方向に固定の壁を設置
      CPBase.generate_walls(@space)
      # プレイヤーオブジェクト（円オブジェクト）作成`
      #player = Player.new(21, 300, 20, 1, C_BLUE)

      # オブジェクトの生成
      # enemyオブジェクトの生成
      @dlang = Dlang.new(rand(200), rand(200), 40, 1, 'images/dlang.png')
      @elephpant = Elephpant.new(rand(800), 200, 40, 1, 'images/elephpant.png')
      @gopher = Gopher.new(rand(200), rand(200), 40, 1, 'images/gopher.png')
      @python = Python.new(rand(500), rand(200), 40, 1, 'images/python.png')

      @enemies = []
      @enemies << @dlang
      @enemies << @elephpant
      @enemies << @gopher
      @enemies << @python

      @enemies.each do |enemy|
        @space.add(enemy)
        @objects << enemy
      end

      # playerの生成
      player = Player.new(400, 500, 45, 10, 0, 1)
      @space.add(player)
      @objects << player

      # Ruby生成
      3.times do
        r = Ruby.new(rand(550)+200 ,rand(350) + 50)
        @space.add(r)
        @objects << r
      end

      # itemboxオブジェクトの生成
      itembox = ItemBox.new(450, 450, 500, 500)
      @space.add(itembox)
      @objects << itembox

      # ゲーム世界に障害物となる静的BOXを追加
      @bg_img = Image.load('images/icesize.png')

      # PlayerがRubyと接触する
      @space.add_collision_handler(Player::COLLISION_TYPE, Ruby::COLLISION_TYPE) do |a, b, arb|
        ruby_Flg = false
        true
      end

      # EnemyがRubyとぶつかる
      @space.add_collision_handler(Enemy::COLLISION_TYPE, Ruby::COLLISION_TYPE) do |a, b, arb|
        if ruby_Flg == false
          @deleting_objs << a.parent_obj
          sound.play
          @@score += 100
        end
      end

      # PlayerがItemBoxに触れる
      @space.add_collision_handler(Player::COLLISION_TYPE, ItemBox::COLLISION_TYPE) do |a, b, arb|
        # 衝突個所（arb.points配列）から、先頭の1つを取得（複数個所ぶつかるケースもあり得るため配列になっている）
        pos = arb.points.first.point
        # 追加アイテム配列に追加
        if @item_Flg == true
          @add_items << pos
          @interval = Time.now + 5
          @item_Flg = false
        elsif @interval < Time.now
          @add_items << pos
          @interval = Time.now + 5
          @item_Flg = false
        end
        true
      end

      # PlayerがItemを取得
      @space.add_collision_handler(Player::COLLISION_TYPE, Item::COLLISION_TYPE) do |a, b, arb|
        @deleting_items << b.parent_obj
        player = a.parent_obj
        player.get_item(@item.data)
      end

      #Playerのジャンプ可能判定
      @space.add_collision_handler(Player::COLLISION_TYPE, CPStaticBox::COLLISION_TYPE) do |a, b, arb|
        player = a.parent_obj
        if player.body.v.y >= 0
          player.jumpable = true
        end
      end

      # playerがenemyに当たってゲーム終了(エンディングへ)
      @space.add_collision_handler(Player::COLLISION_TYPE, Enemy::COLLISION_TYPE) do |a, b, arb|
        player = a.parent_obj
        enemy = b.parent_obj
        player.game_over
      end

      create_walls
    end

    def play
        #BGMを再生する
        if @i == 0
          @bgm.play
          @i = 1
        end
        Window.draw(0, 0, @bg_img)

        # ゲームクリアか判断する
        enemies_Defeated_Num = @deleting_objs.count
        if enemies_Defeated_Num == 4
          enemies_Defeated_Num = 0
          Scene.move_to(:gameclear)
        end

        # 削除予定のアイテムを削除
        @deleting_items.each do | obj |
          @space.remove(obj)
          @objects.delete(obj)
        end

        # 削除予定のオブジェクトを削除
        @deleting_objs.each do | obj2 |
          @space.remove(obj2)
          @objects.delete(obj2)
        end

        @walls.each do | wall |
          wall.draw
        end

        @add_items.each do | obj3 |
          class_Name = [Beer, Apple, Choco]
          @item = class_Name.sample.new(460, 440, 30, 30, 1)
          @space.add(@item)
          @objects << @item
          @add_items.delete(obj3)
        end

        # スコア表示

        Window.draw_font(740, 10, "SCORE: #{@@score}", @font, color: C_BLACK)


        # タイマー表示
        disp_timer

        # ゲーム空間に配置された全てのオブジェクトに対して同じ処理を実施して回る
        @objects.each do |obj|
          obj.move  # 1フレーム分の移動処理
          obj.draw  # 1フレーム分の描画処理
        end
    end

    def self.get_score
      @@score
    end

    def self.get_time
      @@diff_time.to_i
    end

    private
      def scene_transition
        Scene.move_to(:gameover)
      end

      def create_walls
        #一番下
         @walls << CPStaticBox.new(0, 600, 900, 650)
         #1列目
         @walls << CPStaticBox.new(@box_x11, @box_y11,@box_x12, @box_y12)
         @walls << CPStaticBox.new(@box_x21, @box_y11,@box_x22, @box_y12)
         @walls << CPStaticBox.new(@box_x31, @box_y11,@box_x32, @box_y12)
         @walls << CPStaticBox.new(@box_x41, @box_y11,@box_x42, @box_y12)
         #2列目
         @walls << CPStaticBox.new(@box_x11, @box_y21,@box_x12, @box_y22)
         @walls << CPStaticBox.new(@box_x21, @box_y21,@box_x22, @box_y22)
         @walls << CPStaticBox.new(@box_x31, @box_y21,@box_x32, @box_y22)
         @walls << CPStaticBox.new(@box_x41, @box_y21,@box_x42, @box_y22)

        @walls.each do |wall|
          @space.add(wall)
        end
      end

      def disp_timer
        @now_time = Time.now
        @@diff_time = @now_time - @start_time
        countdown = (@limit_time - @@diff_time).to_i
        @min = countdown / 60
        @sec = countdown % 60
        Window.drawFont(10, 10, "#{@min}:#{@sec}", @font, color: C_BLACK)

        @space.step(1 / 60.0)
        if @min < 0
          scene_transition
        end
      end
    end
end
