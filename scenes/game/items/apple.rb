require_relative '../item.rb'
class Apple < Item
    COLLISION_TYPE = 4
    def initialize(x, y, w, h, m, color=C_RED)
        super
        #名前,画面変化,回復量,ボーナス
        @data = ["choco", false, 0, 3]
        @image = Image.load("images/apple.png")
    end
    def data
        @data
    end
end