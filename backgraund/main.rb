require 'dxruby'
require 'chipmunk'

require_relative 'lib/cp'
require_relative 'lib/cp_circle'
require_relative 'lib/cp_box'
require_relative 'lib/cp_static_box'


require_relative 'char'

Window.width=900
Window.height=650

space = CP::Space.new
space.gravity = CP::Vec2.new(0,50)

chars = []

Window.loop do
=begin
	if Input.mouse_push?(M_LBUTTON) then
		char = Char.new(Input.mouse_x,Input.mouse_y,space)
		chars << char
	end
	
	chars.each do |char|
		if Input.key_push?(K_SPACE) then
			char.apply_force(rand(10000) - 5000, rand(10000) - 5000)
		end
		char.draw
	end
=end

	 @bg_img = Image.load('images/back_bg.png')	
	 @space = CP::Space.new
     @space.gravity = CP::Vec2.new(0, 150)
     
     Window.draw(0, 0, @bg_img)
 	 @walls = CPBase.walls
      @walls << CPStaticBox.new(0, 600, 900, 620)
      @walls << CPStaticBox.new(0, 620, 900, 640)
      @walls << CPStaticBox.new(0, 640, 900, 650)
     
      @walls << CPStaticBox.new(180, 480, 360, 500)
      @walls << CPStaticBox.new(540, 480, 720, 500)
      @walls << CPStaticBox.new(360, 200, 540, 220)
      
      #@space.add(@current)
      @walls.each do |wall|
        @space.add(wall)
    end
    
   @walls.each do |wall|
   	   wall.draw
   end
   
   space.step(1/60.0)
end