require_relative '../enemy.rb'
class Gopher < Enemy
    def initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
      super
      @state = nil
    end

    def move
      apply_force(100, 0)
      #@body.v = CP::Vec2.new(400, 0)
    end
end