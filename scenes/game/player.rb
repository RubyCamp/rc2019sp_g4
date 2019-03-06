# 操作対象となるプレイヤーキャラクタ
class Player < CPCircle
  # 衝突判定区分を設定
  COLLISION_TYPE = 1

  # 1フレーム分の移動ロジック
  # キーボードの左右とスペースキーを受け付け、それぞれの方向に加速度を与える
  # 左右キーは押しっ放しに対応する。

  def move
    apply_force(30, 0) if Input.key_down?(K_RIGHT)
    apply_force(-30, 0) if Input.key_down?(K_LEFT)
    apply_force(0, -5000) if Input.key_push?(K_UP)
    apply_force(0, 500) if Input.key_down?(K_DOWN)
  end

end
