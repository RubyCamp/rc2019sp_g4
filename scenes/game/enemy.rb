class Enemy < CPCircle
    attr_reader :x, :y, :img
    COLLISION_TYPE = 0

    def initialize(x, y, r, mass, image = nil, e = 0.8, u = 0.8)
        super
        @x = x
        @y = y
        @dir = 2
        @damage = 100
        @image =  image ? Image.load(image) : Image.load('images/default_square.png')
    end

    def move
        @x += @dir
        if @x >= 900
          @dir = -2
        end
        if @x <= 0
          @dir = 2
        end
        puts @x
    end

    def damage
    end

    def draw
      Window.draw(@x, @y, @image)
    end
end
