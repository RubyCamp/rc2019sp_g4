# 静的BOX
# 重力の影響を受けない矩形オブジェクト
class CPStaticBox < CPBase
  COLLISION_TYPE=9
  attr_accessor :body, :shape

  def initialize(x1, y1, x2, y2, image = nil, e = 0.8, u = 1)
    @body = nil
    if File.exist?('images/images.jpg')
      block = Image.load('images/images.jpg')
    else
      block = Image.new(20, 20)
    end
    verts = [CP::Vec2.new(x1, y1), CP::Vec2.new(x1, y2), CP::Vec2.new(x2, y2), CP::Vec2.new(x2, y1)]
    @shape = CP::Shape::Poly.new(CP::Space::STATIC_BODY, verts, CP::Vec2.new(0, 0))
    @image = image || Image.new(x2 - x1 + 1, y2 - y1 + 1, C_WHITE)
    ((@image.width / block.width) + 1).times do |i|
      @image.draw(block.width * i, 0, block)
    end
    @shape.collision_type = self.class::COLLISION_TYPE
    @x, @y = x1, y1
    shape.e = e
    shape.u = u
  end

  def move
  end

  def draw
    Window.draw(@x, @y, @image)
  end
end
