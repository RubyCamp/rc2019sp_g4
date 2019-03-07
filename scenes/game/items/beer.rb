require_relative '../item.rb'
class Beer < Item
    COLLISION_TYPE = 4
    def initialize(x, y, w, h, m, color=C_RED)
        super
        #名前,画面変化,回復量,ボーナス
        @data = ["beer", true, 0, 0]
        @image = Image.load("images/beer.png")
    end
    def data
        @data
    end
end