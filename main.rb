require 'dxruby'
require 'chipmunk'

require_relative 'scene'
require_relative 'scenes/opening/director'
require_relative 'scenes/game/director'
require_relative 'scenes/gameover/director'
require_relative 'scenes/gameclear/director'

require_relative 'lib/cp'
require_relative 'lib/cp/cp_base'
require_relative 'lib/cp/cp_circle'
require_relative 'lib/cp/cp_box'
require_relative 'lib/cp/cp_static_box'

require_relative 'scenes/game/player'

require_relative 'scenes/game/enemy.rb'
require_relative 'scenes/game/enemies/elephpant.rb'
require_relative 'scenes/game/enemies/dlang.rb'
require_relative 'scenes/game/enemies/gopher.rb'
require_relative 'scenes/game/enemies/python.rb'

require_relative 'scenes/game/ruby.rb'
require_relative 'scenes/game/itemBox.rb'
require_relative 'scenes/game/item.rb'
require_relative 'scenes/game/items/apple.rb'
require_relative 'scenes/game/items/beer.rb'
require_relative 'scenes/game/items/choco.rb'

Window.width = 900
Window.height = 650

Scene.add(Opening::Director.new, :opening)
Scene.add(Game::Director.new, :game)
Scene.add(Gameover::Director.new, :gameover)
Scene.add(Gameclear::Director.new, :gameclear)
Scene.move_to :opening

Window.loop do
    break if Input.key_push?(K_ESCAPE)
    Scene.play
end
