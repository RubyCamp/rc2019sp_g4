
class Ruby < CPBox
   COLLISION_TYPE = 1
   #イメージをrubyへ
   def initialize
      super
      @image=Image.load("../../../images.rb/ruby.png")
      defx=@x
   end
   def move
      #上下に浮遊
      if (defx-100)=<@x&&defx>@x
         apply_force(0,-20)  
      elsif (defx-100)>@x
         apply_force(0,20)
      elsif (defx+100)=>@x
         
      end
   end
end