
class Ruby_ < CPBox
   COLLISION_TYPE = 2
   #イメージをrubyへ
   def initialize(x, y, width, height, mass=1, color=C_BLUE)
      super
      @image=Image.load("images/ruby.png")
      @v=CP::Vec2.new(x,y)
   end
   def move
      #上下に浮遊
      v=@v-@body.p
      apply_force(v.x,v.y)
   end
end