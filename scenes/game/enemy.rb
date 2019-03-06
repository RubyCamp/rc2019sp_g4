class Enemy < CPCircle
    attr_reader :x, :y, :img
    COLLISION_TYPE = 0

    def initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
        super
        @dir = 10
        @damage = 100
        @image =  image ? Image.load(image) : Image.load('images/default_square.png')
    end
    
    def draw
        Window.draw(@body.p.x - @r, @body.p.y - @r, @image )
    end
end
