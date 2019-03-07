class Item < CPBox
    COLLISION_TYPE = 4
    def initialize(x, y,w,h,m,color=C_RED)
        super
        #画面変化,回復量,ボーナス
        @data=["", false, 0, 0]
    end
end