class ItemBox < CPStaticBox
    COLLISION_TYPE = 3
    def initialize(x1,y1,x2,y2)
        super
        @image=Image.load("images/itembox.png")
    end
end