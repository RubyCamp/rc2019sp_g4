require_relative '../item.rb'
class Choco < Item
    COLLISION_TYPE = 4
    def initialize(x, y, w, h, m, color=C_RED)
        super
        #名前,画面変化,回復量,ボーナス
        @data = ["choco", true, 0, 1]
        @image = Image.load("images/choco.png")
    end
    def data
        @data
    end
end