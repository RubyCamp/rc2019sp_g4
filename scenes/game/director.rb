# 同じディレクトリにある「player.rb」「enemy.rb」を読み込む
# 結果、それらの中に定義されているPlayerクラス・Enemyクラスがこのプログラム内で使えるようになる

module Game
# ゲームの進行を司るクラスを定義する
# main.rbを無暗に長くしたくないので、ゲームにまつわる複雑な部分はこのクラスで吸収・隠ぺいする。
  class Director
    def initialize
      # 物理演算空間を作成
      @space = CP::Space.new
      @space.gravity = CP::Vec2.new(0, 2000)
      CPBase.generate_walls(@space)

      player = Player.new(400, 500, 45, 1, C_BLUE)
      @space.add(player)
      @objects = [player]
    end

    def play
      @objects.each do |obj|
        obj.move  # 1フレーム分の移動処理
        obj.draw  # 1フレーム分の描画処理
      end
      @space.step(1 / 60.0)
    end
  end
end
