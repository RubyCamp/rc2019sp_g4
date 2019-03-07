
class Ruby < CPCircle
   COLLISION_TYPE = 2
   #イメージをrubyへ
   def initialize(x, y, r=15, mass=1, color=C_BLUE, e=0.8, u=0.01)
      super
      @image=Image.load("images/ruby.png")
      #@v=CP::Vec2.new(x,y)
   end
   def move
      #上下に浮遊
      #v=@v-@body.p
      @body.v += CP::Vec2.new(0, -16.6)
      #apply_force(,)
   end
end