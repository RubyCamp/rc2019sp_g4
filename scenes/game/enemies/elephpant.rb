require_relative '../enemy.rb'
class Elephpant < Enemy
    def initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
      super
    end

    def move
      apply_force(rand(-10..10), 0)
    end
end