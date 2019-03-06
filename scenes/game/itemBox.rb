class ItemBox < CPBox
    COLLISION_TYPE = 3
    def initialize(x,y,w,h,m,color=C_RED)
        super
        @image=Image.load("images/itembox.png")
    end
end