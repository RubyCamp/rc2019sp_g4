require_relative '../enemy.rb'
class Python < Enemy
    def initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
        super
        #@img = Image.load('images/python.png')
    end
end