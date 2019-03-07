require_relative '../enemy.rb'
class Dlang < Enemy
    def initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
        super
    end

    def move
        #puts 'here is move method'
      
      @body.v = CP::Vec2.new(500, 0)
    end
end