require 'dxruby'
require 'chipmunk'

require_relative 'scene'
require_relative 'scenes/opening/director'
require_relative 'scenes/game/director'
require_relative 'scenes/ending/director'

require_relative 'lib/cp'
require_relative 'lib/cp/cp_base'
require_relative 'lib/cp/cp_circle'
require_relative 'lib/cp/cp_box'
require_relative 'lib/cp/cp_static_box'

require_relative 'scenes/game/player'
require_relative 'scenes/game/enemies/elephpant.rb'
require_relative 'scenes/game/enemies/enemy.rb'

Window.width = 900
Window.height = 650

Scene.add(Opening::Director.new, :opening)
Scene.add(Game::Director.new, :game)
Scene.add(Ending::Director.new, :ending)
Scene.move_to :opening

Window.loop do
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
  
  space.step(1/60.0)
    break if Input.key_push?(K_ESCAPE)
    Scene.play
end
