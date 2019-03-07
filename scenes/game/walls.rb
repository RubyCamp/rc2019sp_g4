class Walls
    def initialize
      #wallsの作成
      @box_x11 = rand(0 .. 450)
      @box_x12 = @box_x11 + 100
      @box_x21 = rand(0 .. 450)
      @box_x22 = @box_x21 + 100
      @box_x31 = rand(450 .. 900)
      @box_x32 = @box_x31 + 100
      @box_x41 = rand(450 .. 900)
      @box_x42 = @box_x41 + 100

      @box_y11 = 480
      @box_y12 = 500
      @box_y21 = 350
      @box_y22 = 370
      @box_y31 = 100
      @box_y32 = 120
      @box_y41 = 50
      @box_y42 = 70

      @walls = []
    end
#wallsの作成
def create_walls
  #一番下
  @walls << CPStaticBox.new(0, 600, 900, 650)
  #1列目
  @walls << CPStaticBox.new(@box_x11, @box_y11,@box_x12, @box_y12)
  @walls << CPStaticBox.new(@box_x21, @box_y11,@box_x22, @box_y12)
  @walls << CPStaticBox.new(@box_x31, @box_y11,@box_x32, @box_y12)
  @walls << CPStaticBox.new(@box_x41, @box_y11,@box_x42, @box_y12)
  #2列目
  @walls << CPStaticBox.new(@box_x11, @box_y21,@box_x12, @box_y22)
  @walls << CPStaticBox.new(@box_x21, @box_y21,@box_x22, @box_y22)
  @walls << CPStaticBox.new(@box_x31, @box_y21,@box_x32, @box_y22)
  @walls << CPStaticBox.new(@box_x41, @box_y21,@box_x42, @box_y22)

  @walls.each do |wall|
    @space.add(wall)
  end
end
    def draw
      @walls.each do | wall |
        p "check"
        wall.draw
      end
    end
end
