class Enemy
    attr_reader :x, :y, :img
    def initialize
        @img = Image.load('images/default_square.png')
        @x = 0
        @y = 2
        @dir = 2
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
        Window.draw(@x, @y, @img)
    end
end

class Elephpant < Enemy
    def initialize
    end
end
