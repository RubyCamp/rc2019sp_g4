require_relative '../enemy.rb'
class Gopher < Enemy
    def initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
      super
      @state = nil
    end

    def move
      if rand(100) % 3 == 0 
        apply_force(rand(-10..10), -50)
      else
        apply_force(rand(-10..10), 10)
      end
    end
end