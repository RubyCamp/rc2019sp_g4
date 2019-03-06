require 'dxruby'

font = Font.new(32)

score = 3 * 60  # 分*60

Window.loop do
	Window.drawFont(100, 10, "#{score}", font)
end
