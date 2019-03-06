class Item < CPBox
    COLLISION_TYPE = 4
    def initialize(x, y,w,h,m,color=C_RED)
        super
        @image=Image.load("images/ruby.png")
    end
end