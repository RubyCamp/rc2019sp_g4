class CPCircle < CPBase

  attr_accessor :body, :shape

  def initialize(x, y, r, mass, image = nil, e, u)
    moment = CP::moment_for_circle(mass, 0, r, CP::Vec2.new(0, 0))
    @body = CP::Body.new(mass, moment)
    @body.p = CP::Vec2.new(x + r, y + r)
    @shape = CP::Shape::Circle.new(@body, r, CP::Vec2.new(0, 0))
    @shape.parent_obj = self
    @image = image
    @shape.collision_type = self.class::COLLISION_TYPE
    @r = r
    shape.e = e
    shape.u = u
  end

  def draw
    Window.draw(@body.p.x - @r, @body.p.y - @r, @image)
  end
end
