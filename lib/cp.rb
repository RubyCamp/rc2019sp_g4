require_relative 'cp/cp_base'
require_relative 'cp/cp_circle'
require_relative 'cp/cp_box'
require_relative 'cp/cp_static_box'

class CP::Shape::Circle
  attr_accessor :parent_obj
end

class CP::Shape::Poly
  attr_accessor :parent_obj
end

class CPBase
  def self.walls
    walls = []
    walls << CPStaticBox.new(0, 768, 1024, 790)
    walls << CPStaticBox.new(-20, 0, 0, 768)
    walls << CPStaticBox.new(0, -20, 1024, 0)
    walls << CPStaticBox.new(1024, 0, 1044, 768)
    walls
  end

  def apply_force(x, y)
    body.apply_impulse(CP::Vec2.new(x, y), CP::Vec2.new(0, 0))
  end

  def set_eu(e, u)
    shape.e = e
    shape.u = u
  end
end
